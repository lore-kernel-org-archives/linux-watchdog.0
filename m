Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:40257 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756636Ab2DXK1F (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Apr 2012 06:27:05 -0400
Message-ID: <4F967F85.1030907@st.com>
Date: Tue, 24 Apr 2012 15:55:09 +0530
From: Viresh Kumar <viresh.kumar@st.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: viresh kumar <viresh.linux@gmail.com>,
	"wim@iguana.be" <wim@iguana.be>,
	spear-devel <spear-devel@list.st.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pawel Moll <Pawel.Moll@arm.com>
Subject: Re: [PATCH V2] watchdog: mpcore: Add DT probing support for ARM mpcore
 watchdog
References: <18a4584c24041ceb8a1972dd5ee70cf7c59fed21.1334932839.git.viresh.kumar@st.com> <7dbd64f72527cf92af0ec38f45275d71207d5ec5.1335008301.git.viresh.kumar@st.com> <4F9514AA.10403@arm.com> <CAOh2x=kroSi8MZBhYVOhrDm08q1B9LS_9P7NPAfHC01-MHaOCQ@mail.gmail.com> <4F9547E3.4000709@arm.com> <CAOh2x=kQvjP5SYfJsTXkZyNe3UsS-=pXUBKoQ=SsMUNcPGjzuA@mail.gmail.com> <4F9573B8.9050607@arm.com> <CAOh2x=n5Zm9MR5twDY-CUA-ppE9ADXrg25XCT5RKM++v6=tcpA@mail.gmail.com> <4F957A0C.7060607@arm.com> <CAOh2x=kyJ3tG3go0TQ2LXLOKDf0m9=uz1=KC7asMS0FSxtx9uA@mail.gmail.com> <4F957F62.5090605@arm.com> <CAOh2x=n4JdZdZoofHpr+9G254ZL_kxyWEHHRr5W4PB4GgjeHsQ@mail.gmail.com> <4F9582AF.6040501@arm.com>
In-Reply-To: <4F9582AF.6040501@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 4/23/2012 9:56 PM, Marc Zyngier wrote:
>> > Looking at your confidence, i am starting to feel, i am wrong here ;)
> Well, having written the code that ensures request_irq() fails when
> passed a PPI, I'd be very worried if the above started to be working... 

And yes. I was wrong. 

WARNING: at /home/vireshk/work/spear/kernel/linux-2.6/kernel/irq/manage.c:1368 request_threaded_irq+0x128/0x148()
Modules linked in:
Backtrace: 
[<c000c200>] (dump_backtrace+0x0/0x10c) from [<c0249814>] (dump_stack+0x18/0x1c)
 r6:00000558 r5:c005cb34 r4:00000000
[<c02497fc>] (dump_stack+0x0/0x1c) from [<c00157d4>] (warn_slowpath_common+0x54/0x6c)
[<c0015780>] (warn_slowpath_common+0x0/0x6c) from [<c0015810>] (warn_slowpath_null+0x24/0x28)
 r8:0000001e r7:c01f69c4 r6:00000000 r5:c033b840 r4:ee21770c
[<c00157ec>] (warn_slowpath_null+0x0/0x28) from [<c005cb34>] (request_threaded_irq+0x128/0x148)
[<c005ca0c>] (request_threaded_irq+0x0/0x148) from [<c005e95c>] (devm_request_threaded_irq+0x5c/0x94)
[<c005e900>] (devm_request_threaded_irq+0x0/0x94) from [<c02460b8>] (mpcore_wdt_probe+0x88/0x2d4)
[<c0246030>] (mpcore_wdt_probe+0x0/0x2d4) from [<c0180548>] (platform_drv_probe+0x20/0x24)
 r7:00000000 r6:ee101c08 r5:c03601e4 r4:c038abf4

-- 
viresh
