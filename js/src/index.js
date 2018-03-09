//@flow
import polly from 'babel-polyfill'; //eslint-ignore no-unused-vars

import forge from 'node-forge';
import newUuid from 'uuid/v4';
import MurmurHash3 from './murmur';
// import {performance} from 'perf_hooks';

const hashers = [
    ['md5', (values: string[]): string => {
        const hash = forge.md.md5.create();
        values.forEach((x) => hash.update(x));
        return hash.digest().toHex();
    }],
    ['sha1', (values: string[]): string => {
        const hash = forge.md.sha1.create();
        values.forEach((x) => hash.update(x));
        return hash.digest().toHex();
    }],
    ['sha256', (values: string[]): string => {
        const hash = forge.md.sha256.create();
        values.forEach((x) => hash.update(x));
        return hash.digest().toHex();
    }],
    ['murmur', (values: string[]): string => {
        const hash = MurmurHash3();
        values.forEach((x) => hash.hash(x));
        return hash.result();
    }],
];
const runs = [[500, 10], [5000, 10], [5000, 100], [50000, 10], [50000, 100]];

async function main() {
    for (const [name, hasher] of hashers) {
        for (const [rows, width] of runs) {
            const uuids = generateUuids(width);

            const t0 = performance.now();
            for (let i = 0; i < rows; i++) {
                hasher(uuids);
            }

            const t1 = performance.now();

            write(`${name} ${rows}x${width}: ${Math.trunc(t1 - t0)}ms`);

            await new Promise((resolve) => setTimeout(resolve, 100));
        }
    }
}

function generateUuids(width: number) {
    const uuids: string[] = new Array(width);
    for (let i = 0; i < width; i++) {
        uuids[i] = newUuid();
    }
    return uuids;
}

function write(msg: string) {
    const element = document.createElement('div');
    element.innerHTML = msg;
    document.body.appendChild(element);
}

main();
