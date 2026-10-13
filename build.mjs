import { mkdir, copyFile } from 'node:fs/promises';

await mkdir('www', { recursive: true });
for (const file of ['index.html', 'manifest.webmanifest', 'icon.svg', 'sw.js']) {
  await copyFile(file, `www/${file}`);
}
console.log('Ray AI web shell copied to www/.');
