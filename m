Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:51169 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdKHSPu (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Nov 2017 13:15:50 -0500
Date: Wed, 8 Nov 2017 10:15:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: oops with 4.14-rc8 when opening and closing /dev/watchdog0
Message-ID: <20171108181548.GA19661@roeck-us.net>
References: <18b00f23-b71d-e6cb-8a51-9a48bf02d3b3@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b00f23-b71d-e6cb-8a51-9a48bf02d3b3@prevas.dk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 08, 2017 at 02:26:34PM +0100, Rasmus Villemoes wrote:
> Running current master (4.14.0-rc8-00009-gfbc3edf) I can reproduce the
> below quite consistently, though there are some variations in the stack
> trace. It happens when I start and stop busybox watchdog on
> /dev/watchdog0 a few times (sometimes on start, sometimes on stop,
> almost always after at most 3 starts/stops). watchdog0 is a gpio
> watchdog with the below DT entry.
> 
>         gpio-wdt {
>                 status = "okay";
>                 compatible = "linux,wdt-gpio";
>                 hw_margin_ms = <0xfa>;
>                 hw_algo = "toggle";
>                 gpios = <0x15 0x19 0x0>;
>                 always-running;
>         };
> 
> The 6b6b6b6b suggests some kind of use-after-free, I think.
> 
> This is a ARM board based on LS1021A. Unfortunately, I hit this in the
> process of starting to use a mainline-based kernel for the board, so I
> don't have any previous known-working kernel to start a bisection from.
> I'll try to see if I can get a 4.13 one to boot with the same .dtb and
> .config, but in the meantime perhaps someone can see something obvious.
> 

Please let me know if the following two patches help.

https://patchwork.kernel.org/patch/9970181/
https://patchwork.kernel.org/patch/9970187/

Thanks,
Guenter

> Thanks,
> Rasmus
> 
> 
> Unable to handle kernel paging request at virtual address 6b6b6d3b
> pgd = 80003000
> [6b6b6d3b] *pgd=80000080005003, *pmd=00000000
> Internal error: Oops: 206 [#1] SMP ARM
> Modules linked in: bridge stp llc
> CPU: 0 PID: 1931 Comm: watchdog Not tainted 4.14.0-rc8-00009-gfbc3edf #1
> Hardware name: Freescale LS1021A
> task: be4a8d40 task.stack: bd1d4000
> PC is at module_put+0x8/0x68
> LR is at __fput+0x108/0x1b0
> pc : [<8027f090>]    lr : [<802ef898>]    psr: 200d0013
> sp : bd1d5f20  ip : 00000000  fp : 00000000
> r10: bf0877c8  r9 : be805608  r8 : be04ccd0
> r7 : be3f57c8  r6 : 00000008  r5 : bf0877c8  r4 : be3f57c0
> r3 : bf2241a0  r2 : 6b6b6b6a  r1 : 00000000  r0 : 6b6b6b6b
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 30c5387d  Table: bd189340  DAC: fffffffd
> Process watchdog (pid: 1931, stack limit = 0xbd1d4210)
> Stack: (0xbd1d5f20 to 0xbd1d6000)
> 5f20: 00000000 00000000 0000002b be4a917c be4a8d40 be412b80 81055310
> be49897c
> 5f40: 00000000 0000044c 00000000 80235014 be4a8d40 be498940 bd1d4000
> bd1d5f70
> 5f60: be49897c 80220a10 00000000 be4a9068 be4a8d40 be4a9068 bd80c5c0
> 000000f8
> 5f80: 00000000 80220fe8 000f4240 7ed9bccc 0007a154 000000f8 80207544
> 80220ffc
> 5fa0: 000f4240 80207380 000f4240 7ed9bccc 00000000 000874fe 00000001
> 00000000
> 5fc0: 000f4240 7ed9bccc 0007a154 000000f8 00000f00 00000000 76f89000
> 00000000
> 5fe0: 76eb87e0 7ed9b9b4 00021c9c 76eb87f0 600d0010 00000000 00000000
> 00000000
> [<8027f090>] (module_put) from [<00000000>] (  (null))
> Code: e3a00001 e12fff1e e3500000 012fff1e (e59021d0)
> ---[ end trace d8b636b1833a6c9e ]---
> Kernel panic - not syncing: Fatal exception
> CPU1: stopping
> CPU: 1 PID: 64 Comm: kworker/u4:1 Tainted: G      D
> 4.14.0-rc8-00009-gfbc3edf #1
> Hardware name: Freescale LS1021A
> Workqueue: events_unbound flush_to_ldisc
> [<8020c8e8>] (unwind_backtrace) from [<8020a728>] (show_stack+0x10/0x14)
> [<8020a728>] (show_stack) from [<80661704>] (dump_stack+0x7c/0x98)
> [<80661704>] (dump_stack) from [<8020bc24>] (handle_IPI+0xdc/0x184)
> [<8020bc24>] (handle_IPI) from [<802013ac>] (gic_handle_irq+0x70/0x78)
> [<802013ac>] (gic_handle_irq) from [<806776f8>] (__irq_svc+0x58/0x74)
> Exception stack(0xbe0d1e58 to 0xbe0d1ea0)
> 1e40:                                                       00000000
> 000000fd
> 1e60: 00000000 00000ff8 be18ca40 00000000 00000000 c08a3000 bdb09c5b
> bdb09c5b
> 1e80: 00000052 00000000 be18cbbc be0d1ea8 802502c0 8045cd2c 60010013
> ffffffff
> [<806776f8>] (__irq_svc) from [<8045cd2c>]
> (n_tty_receive_buf_common+0x804/0x8bc)
> [<8045cd2c>] (n_tty_receive_buf_common) from [<8045cdf4>]
> (n_tty_receive_buf2+0x10/0x18)
> [<8045cdf4>] (n_tty_receive_buf2) from [<8045f374>]
> (tty_port_default_receive_buf+0x44/0x54)
> [<8045f374>] (tty_port_default_receive_buf) from [<8045ebfc>]
> (flush_to_ldisc+0x8c/0xac)
> [<8045ebfc>] (flush_to_ldisc) from [<80231224>]
> (process_one_work+0x1b0/0x314)
> [<80231224>] (process_one_work) from [<80232118>]
> (worker_thread+0x2cc/0x424)
> [<80232118>] (worker_thread) from [<80236598>] (kthread+0x130/0x148)
> [<80236598>] (kthread) from [<80207440>] (ret_from_fork+0x14/0x34)
> 
