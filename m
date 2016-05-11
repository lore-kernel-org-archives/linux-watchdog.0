Return-path: <sasha.levin@oracle.com>
Subject: Re: [PATCH 06/10] watchdog: ebc-c384_wdt: Utilize the ISA bus driver
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        gregkh@linuxfoundation.org, tglx@linutronix.de, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wim@iguana.be,
        linux@roeck-us.net, linus.walleij@linaro.org, gnurou@gmail.com
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
 <1f5bf2e21006f0fd4f10ab3948cf69a737c0b039.1460040201.git.vilhelm.gray@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org
From: Sasha Levin <sasha.levin@oracle.com>
Message-ID: <57336622.9070508@oracle.com>
Date: Wed, 11 May 2016 13:04:34 -0400
MIME-Version: 1.0
In-Reply-To: <1f5bf2e21006f0fd4f10ab3948cf69a737c0b039.1460040201.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 04/07/2016 10:47 AM, William Breathitt Gray wrote:
> The WinSystems EBC-C384 watchdog timer is controlled via ISA bus
> communication. As such, the ISA bus driver is more appropriate than the
> platform driver for the WinSystems EBC-C384 watchdog timer driver.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hey William,

I'm seeing this on boot:

kernel BUG at drivers/base/driver.c:153!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc7-next-20160511-sasha-00024-g13dfe33 #3081
task: ffff88005b2f8000 ti: ffff88005b300000 task.ti: ffff88005b300000
RIP: driver_register (drivers/base/driver.c:153 (discriminator 1))
RSP: 0000:ffff88005b307c68  EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffb3987c30 RCX: 1ffffffff68acf26
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffffffffb4567930
RBP: ffff88005b307c88 R08: 1ffffffff606e3dc R09: dffffc0000000000
R10: 0000000080000000 R11: 1ffffffff79c42e2 R12: ffffffffb45678a0
R13: ffffffffb3987c38 R14: ffffffffb3987c30 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff880063e40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000030023000 CR4: 00000000000406a0
Stack:
1ffff1000b660fa4 dffffc0000000000 0000000000000000 ffffffffb3987c00
ffff88005b307cf0 ffffffffa5bf826d ffff88005b307dc0 ffffffffb3987c30
ffffffffb3987ca8 ffffffffb39847e0 ffffffffb39847e0 00000000f673090a
Call Trace:
isa_register_driver (drivers/base/isa.c:123)
dio48e_driver_init (drivers/gpio/gpio-104-dio-48e.c:396)
do_one_initcall (init/main.c:770)
kernel_init_freeable (init/main.c:834 init/main.c:843 init/main.c:861 init/main.c:1008)
kernel_init (init/main.c:936)
ret_from_fork (arch/x86/entry/entry_64.S:390)
Code: be 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 31 00 74 05 e8 4a 18 be fd 49 83 bc 24 90 00 00 00 00 75 13 e8 2a 89 a0 fd <0f> 0b 48 c7 c7 40 21 51 b4 e8 6f 78 58 ff e8 17 89 a0 fd 49 8d
All code
========
   0:   be 00 00 00 00          mov    $0x0,%esi
   5:   00 fc                   add    %bh,%ah
   7:   ff df                   lcallq *<internal disassembler error>
   9:   48 89 f9                mov    %rdi,%rcx
   c:   48 c1 e9 03             shr    $0x3,%rcx
  10:   80 3c 31 00             cmpb   $0x0,(%rcx,%rsi,1)
  14:   74 05                   je     0x1b
  16:   e8 4a 18 be fd          callq  0xfffffffffdbe1865
  1b:   49 83 bc 24 90 00 00    cmpq   $0x0,0x90(%r12)
  22:   00 00
  24:   75 13                   jne    0x39
  26:   e8 2a 89 a0 fd          callq  0xfffffffffda08955
  2b:*  0f 0b                   ud2             <-- trapping instruction
  2d:   48 c7 c7 40 21 51 b4    mov    $0xffffffffb4512140,%rdi
  34:   e8 6f 78 58 ff          callq  0xffffffffff5878a8
  39:   e8 17 89 a0 fd          callq  0xfffffffffda08955
  3e:   49 8d 00                lea    (%r8),%rax

Code starting with the faulting instruction
===========================================
   0:   0f 0b                   ud2
   2:   48 c7 c7 40 21 51 b4    mov    $0xffffffffb4512140,%rdi
   9:   e8 6f 78 58 ff          callq  0xffffffffff58787d
   e:   e8 17 89 a0 fd          callq  0xfffffffffda0892a
  13:   49 8d 00                lea    (%r8),%rax
RIP driver_register (drivers/base/driver.c:153 (discriminator 1))
RSP <ffff88005b307c68>
---[ end trace 96103422392be10c ]---
