# Pod-merge Benchmarks

## TL;DR | Results

### On an iPhone 11 Pro, iOS 13.1, Low Power Mode (4 Repeated launches, without reboots)

**Average dylib loading time**: 
213.2 ms (before merging)
186.2 ms (after merging)

**Improvement**: **~13%** (- 27 ms) 

According to our experience in Grab, improvements on older devices like the iPhone 5, 5c, 6 are much more drastic. As a general rule, we've seen dylib loading times decrease by **upto 50 ms** per dynamic framework on our user's slowest devices.  The improvement is ofcourse higher on iOS versions older than iOS 13, which do not have the new shared dyld cache [dyld 3](https://developer.apple.com/videos/play/wwdc2017/413/).

## Raw Data

### Merged

#### Low Power Mode on iPhone 11 Pro

Total pre-main time: 316.07 milliseconds (100.0%)
         dylib loading time: 236.72 milliseconds (74.8%)
        rebase/binding time:  13.95 milliseconds (4.4%)
            ObjC setup time:  13.11 milliseconds (4.1%)
           initializer time:  52.28 milliseconds (16.5%)
           slowest intializers :
             libSystem.B.dylib :   5.91 milliseconds (1.8%)
   libBacktraceRecording.dylib :   9.05 milliseconds (2.8%)
                    Networking :  32.91 milliseconds (10.4%)

Total pre-main time: 258.50 milliseconds (100.0%)
         dylib loading time: 150.18 milliseconds (58.1%)
        rebase/binding time:  17.00 milliseconds (6.5%)
            ObjC setup time:  14.33 milliseconds (5.5%)
           initializer time:  76.96 milliseconds (29.7%)
           slowest intializers :
             libSystem.B.dylib :  22.90 milliseconds (8.8%)
   libBacktraceRecording.dylib :   9.07 milliseconds (3.5%)
                    Networking :  39.54 milliseconds (15.2%)

Total pre-main time: 200.97 milliseconds (100.0%)
         dylib loading time: 126.97 milliseconds (63.1%)
        rebase/binding time:  11.40 milliseconds (5.6%)
            ObjC setup time:  13.50 milliseconds (6.7%)
           initializer time:  49.08 milliseconds (24.4%)
           slowest intializers :
             libSystem.B.dylib :   5.78 milliseconds (2.8%)
   libBacktraceRecording.dylib :   9.09 milliseconds (4.5%)
                    Networking :  29.86 milliseconds (14.8%)

Total pre-main time: 308.02 milliseconds (100.0%)
         dylib loading time: 233.73 milliseconds (75.8%)
        rebase/binding time:  12.14 milliseconds (3.9%)
            ObjC setup time:  12.64 milliseconds (4.1%)
           initializer time:  49.49 milliseconds (16.0%)
           slowest intializers :
             libSystem.B.dylib :   5.77 milliseconds (1.8%)
   libBacktraceRecording.dylib :   9.09 milliseconds (2.9%)
                    Networking :  30.36 milliseconds (9.8%)


### Non - merged 

#### Low Power Mode on iPhone 11 Pro

Total pre-main time: 242.23 milliseconds (100.0%)
         dylib loading time: 172.70 milliseconds (71.2%)
        rebase/binding time:   5.49 milliseconds (2.2%)
            ObjC setup time:  12.58 milliseconds (5.1%)
           initializer time:  51.45 milliseconds (21.2%)
           slowest intializers :
             libSystem.B.dylib :   7.58 milliseconds (3.1%)
   libBacktraceRecording.dylib :   9.43 milliseconds (3.8%)
                  AFNetworking :  30.49 milliseconds (12.5%)

Total pre-main time: 385.43 milliseconds (100.0%)
         dylib loading time: 311.68 milliseconds (80.8%)
        rebase/binding time:   9.94 milliseconds (2.5%)
            ObjC setup time:  13.66 milliseconds (3.5%)
           initializer time:  50.13 milliseconds (13.0%)
           slowest intializers :
             libSystem.B.dylib :   3.98 milliseconds (1.0%)
   libBacktraceRecording.dylib :   9.16 milliseconds (2.3%)
                  AFNetworking :  32.64 milliseconds (8.4%)

Total pre-main time: 266.50 milliseconds (100.0%)
         dylib loading time: 190.51 milliseconds (71.4%)
        rebase/binding time:  10.32 milliseconds (3.8%)
            ObjC setup time:  13.87 milliseconds (5.2%)
           initializer time:  51.78 milliseconds (19.4%)
           slowest intializers :
             libSystem.B.dylib :   4.51 milliseconds (1.6%)
   libBacktraceRecording.dylib :   9.14 milliseconds (3.4%)
                  AFNetworking :  33.70 milliseconds (12.6%)

Total pre-main time: 257.99 milliseconds (100.0%)
         dylib loading time: 180.89 milliseconds (70.1%)
        rebase/binding time:  12.22 milliseconds (4.7%)
            ObjC setup time:  14.51 milliseconds (5.6%)
           initializer time:  50.36 milliseconds (19.5%)
           slowest intializers :
             libSystem.B.dylib :   4.19 milliseconds (1.6%)
   libBacktraceRecording.dylib :   9.13 milliseconds (3.5%)
                  AFNetworking :  32.56 milliseconds (12.6%)