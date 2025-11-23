=== x86doc - Run Suite Script ===
Maven detected.
Java detected.
Python detected.
Building Java SignatureGenerator...
[INFO] Scanning for projects...
[INFO] 
[INFO] --------------------< hjlebbink:SignatureGenerator >--------------------
[INFO] Building SignatureGenerator 1.0.0-SNAPSHOT   
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- clean:3.2.0:clean (default-clean) @ SignatureGenerator ---
[INFO] Deleting C:\dev\x86doc\Java\SignatureGenerator\target
[INFO] 
[INFO] --- resources:3.3.1:resources (default-resources) @ SignatureGenerator ---
[INFO] skip non existing resourceDirectory C:\dev\x86doc\Java\SignatureGenerator\src\main\resources     
[INFO]
[INFO] --- compiler:3.14.1:compile (default-compile) @ SignatureGenerator ---
[INFO] Recompiling the module because of changed source code.
[INFO] Compiling 2 source files with javac [debug release 21] to target\classes
[INFO] 
[INFO] --- resources:3.3.1:testResources (default-testResources) @ SignatureGenerator ---
[INFO] skip non existing resourceDirectory C:\dev\x86doc\Java\SignatureGenerator\src\test\resources     
[INFO]
[INFO] No sources to compile
[INFO]
[INFO] --- surefire:3.0.0:test (default-test) @ SignatureGenerator ---
[INFO] No tests to run.
[INFO]
[INFO] --- jar:3.4.1:jar (default-jar) @ SignatureGenerator ---
[INFO] Building jar: C:\dev\x86doc\Java\SignatureGenerator\target\SignatureGenerator-1.0.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------  
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------  
[INFO] Total time:  2.945 s
[INFO] Finished at: 2025-11-23T13:28:26+01:00
[INFO] ------------------------------------------------------------------------  
Running Java converter.Main to generate signatures...
[INFO] Scanning for projects...
[INFO] 
[INFO] --------------------< hjlebbink:SignatureGenerator >--------------------
[INFO] Building SignatureGenerator 1.0.0-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  0.455 s
[INFO] Finished at: 2025-11-23T13:28:28+01:00
[INFO] ------------------------------------------------------------------------
[ERROR] Unknown lifecycle phase ".mainClass=converter.Main". You must specify a valid lifecycle phase or [ERR[[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please re[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] For more information about the errors and possible solutions, please re[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.        wing articles:
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.     or more information about the errors and possible solutions, please re
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.  ] For more information about the errors and possible solutions, please re
[ERROR]
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.        
[ERROR]
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/LifecyclePhaseNotFoundException
Activating virtual environment
Installing Python dependencies (pdfminer.six)...
Requirement already satisfied: pip in c:\dev\x86doc\.venv\lib\site-packages (25.3)
Requirement already satisfied: pdfminer.six in c:\dev\x86doc\.venv\lib\site-packages (20251107)
Requirement already satisfied: charset-normalizer>=2.0.0 in c:\dev\x86doc\.venv\lib\site-packages (from pdfminer.six) (3.4.4)
Requirement already satisfied: cryptography>=36.0.0 in c:\dev\x86doc\.venv\lib\site-packages (from pdfminer.six) (46.0.3)
Requirement already satisfied: cffi>=2.0.0 in c:\dev\x86doc\.venv\lib\site-packages (from cryptography>=36.0.0->pdfminer.six) (2.0.0)
Requirement already satisfied: pycparser in c:\dev\x86doc\.venv\lib\site-packages (from cffi>=2.0.0->cryptography>=36.0.0->pdfminer.six) (2.23)
WARNING: No PDF files found in the workspace. The extract script requires Intel x86 manual PDF(s). If you have them locally, place them in the workspace and re-run the script.
=== x86doc run-suite completed (see messages) ===