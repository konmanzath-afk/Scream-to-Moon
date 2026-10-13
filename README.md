# Scream to Moon

เกมทดลองบนเว็บที่ใช้เสียงจากไมโครโฟนควบคุมตัวละคร และมีตัวอย่างการเชื่อมต่อ MetaMask กับ Token/Smart Contract บน BNB Smart Chain Testnet

> **สถานะ:** โปรเจกต์นี้เป็นตัวอย่างเพื่อการเรียนรู้และทดสอบบน Testnet เท่านั้น ยังไม่ควรใช้กับเงินจริงหรือ Mainnet โดยไม่ผ่านการตรวจสอบความปลอดภัย

## ไฟล์ในโปรเจกต์

- `index.html` — เกม, UI, การอ่านไมโครโฟน และการเรียก Smart Contract ผ่าน MetaMask RPC
- `contracts/ScreamToMoon.sol` — Game Contract ตัวอย่างที่รับที่อยู่ ERC-20/BEP-20 Token ผ่าน constructor และจ่ายรางวัลให้ผู้เล่น
- `.gitignore` — รายการไฟล์ที่ไม่ควรส่งขึ้น GitHub

## สิ่งที่ต้องมีก่อน

- Browser ที่ติดตั้ง MetaMask
- BNB Smart Chain Testnet ใน MetaMask (Chain ID `97`, hex `0x61`)
- tBNB สำหรับจ่ายค่า Gas
- Token ที่รองรับ ERC-20/BEP-20 และใช้ 18 decimals ในตัวอย่างนี้
- Git หากต้องการ push repository จากเครื่องตัวเอง

## วิธีตั้งค่าให้ใช้ Token ของตัวเอง

1. สร้าง Token ของตัวเองบน **BNB Smart Chain Testnet** ด้วยเครื่องมือที่คุณเลือก และบันทึก Token Contract Address ไว้
2. เปิด `contracts/ScreamToMoon.sol` ใน Remix IDE หรือเครื่องมือ Solidity ที่รองรับ `pragma solidity ^0.8.20` แล้ว Compile
3. Deploy `ScreamToMoon` โดยส่ง Token Contract Address ของคุณเข้า constructor `_smoonToken`
4. โอน Token ของคุณไปยังที่อยู่ Game Contract ที่เพิ่ง Deploy เพื่อเติมคลังสำหรับรางวัลเริ่มต้น 10 Token และรางวัลจากคะแนน
5. เปิด `index.html` แล้วแทนค่าศูนย์ใน `GAME_CONTRACT` ด้วย Game Contract Address ที่เพิ่ง Deploy และแทนค่าศูนย์ใน `SMOON_CONTRACT` ด้วย Token Contract Address ของคุณ
6. ตรวจสอบว่า Token ใน `SMOON_CONTRACT` เป็น Token เดียวกับที่ระบุใน constructor ของ Game Contract
7. เปิดหน้าเว็บผ่าน `http://localhost` หรือ HTTPS (เช่น VS Code Live Server หรือ GitHub Pages) เพื่อให้การขอใช้ไมโครโฟนทำงานได้ตามข้อกำหนดของ Browser
8. ทดสอบด้วย Wallet แยกจาก Wallet ผู้ Deploy: เชื่อม MetaMask บน BSC Testnet, ขอรับรางวัลเริ่มต้น และทดลองเล่น/Claim Reward

## วิธีรันในเครื่อง

ใช้ VS Code ติดตั้งส่วนขยาย Live Server จากนั้นคลิกขวา `index.html` แล้วเลือก **Open with Live Server** หรือใช้ local web server อื่นก็ได้ ไม่จำเป็นต้องติดตั้ง Node.js สำหรับหน้าเกมเวอร์ชันนี้

## ข้อจำกัดและคำเตือนด้านความปลอดภัย

- `claimReward(score)` รับคะแนนที่ส่งมาจากหน้าเว็บโดยตรง ผู้ใช้จึงสามารถดัดแปลงคะแนนที่ส่งเข้า Contract ได้ ตัวอย่างนี้ **ไม่ได้พิสูจน์ว่าคะแนนมาจากการเล่นจริง** และเหมาะกับ Testnet/เดโมเท่านั้น
- Contract ตัวอย่างไม่มีระบบป้องกันการ Claim Reward ซ้ำตามคะแนนหรือระบบตรวจสอบคะแนนจากเซิร์ฟเวอร์/ลายเซ็น
- ผู้ Deploy ต้องเติม Token ให้ Game Contract เอง มิฉะนั้น `claimInitial` หรือ `claimReward` อาจล้มเหลวเพราะยอด Token ไม่พอ
- `initialReward = 10 ether` และ `rewardPerPoint = 1 ether` สมมติว่า Token ใช้ 18 decimals
- เวอร์ชันนี้ยัง **ไม่ได้หักค่าเข้าเล่น 1 SMOON** และจำนวน Checkpoint ยังไม่ตรงกับแผนล่าสุด ต้องเพิ่มและทดสอบก่อนเผยแพร่เป็นเวอร์ชันสมบูรณ์
- ห้าม commit Private Key, Secret Recovery Phrase, ไฟล์ `.env` หรือข้อมูลลับใด ๆ ขึ้น GitHub
- ห้ามใช้ Contract ตัวอย่างนี้กับเงินจริง/Mainnet โดยไม่ให้ผู้เชี่ยวชาญตรวจสอบและแก้ระบบตรวจสอบคะแนนก่อน

## License

MIT — ดูไฟล์ `LICENSE`
