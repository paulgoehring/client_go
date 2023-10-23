console.log('start of file');
const fs = require('fs');
// Specify the path to the directory you want to list (current directory in this case).
const directoryPath = '/.';

// Use fs.readdir() to read the directory.
fs.readdir(directoryPath, (err, files) => {
  if (err) {
    console.error('Error reading directory:', err);
    return;
  }

  // 'files' is an array of filenames in the specified directory.
  console.log('Filenames in the current directory:');
  files.forEach((file) => {
    console.log(file);
  });
});

fs.readdir(directoryPath, (err, files) => {
    if (err) {
      console.error('Error reading directory:', err);
    } else {
      // List all files and their attributes
      files.forEach((file) => {
        const filePath = `${directoryPath}${file}`;
        fs.stat(filePath, (err, stats) => {
          if (err) {
            console.error('Error getting file attributes:', err);
          } else {
            console.log('Filename:', file);
            console.log('File Size (bytes):', stats.size);
            console.log('Is Directory:', stats.isDirectory());
            console.log('File Permissions:', stats.mode.toString(8)); // Display file permissions in octal format
            console.log('------------------------');
          }
        });
      });
    }
  });

const { execSync } = require('child_process');

const command = './client'; // Replace this with the path to your executable

try {
  const result = execSync(command, { encoding: 'utf-8', shell: '/usr/bin/sh'});
  console.log(`stdout: ${result}`);
} catch (error) {
  console.error(`Error: ${error.message}`);
}

console.log('helooaweasd');

const jwtData = 'YourJWTTokenHere'; // Replace with your JWT data

// File path
const filePath2 = '/secrets/client.jwt';

fs.writeFile(filePath2, jwtData, (err) => {
    if (err) {
        console.error('Error writing to the file:', err);
    } else {
        console.log('JWT data has been written to client.jwt');
    }
});