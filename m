Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35485 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbCaTh2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Mar 2015 15:37:28 -0400
Received: by qgh3 with SMTP id 3so24262823qgh.2
        for <linux-watchdog@vger.kernel.org>; Tue, 31 Mar 2015 12:37:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
Date: Tue, 31 Mar 2015 12:37:27 -0700
Message-ID: <CAL1qeaG6A99tOXnU8DPze3VwxMRSpyoDt30=OpT5=nAFVrNujg@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: imgpdc: Fix NULL pointer dereference on probe
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Mar 31, 2015 at 11:49 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
>
> pdc_wdt_probe() called pdc_wdt_stop() before watchdog_set_drvdata(),
> resulting in the following NULL pointer dereference:
>
>   CPU 0 Unable to handle kernel paging request at virtual address 0000008c, epc == 8082a2b8, ra == 8082a914
>   Oops[#1]:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc5+ #102
>   task: 8f8c0000 ti: 8f89e000 task.ti: 8f89e000
>   $ 0   : 00000000 8082a914 00000000 dc8ba200
>   $ 4   : 8faf9418 80ac0000 8f9cdc10 00008012
>   $ 8   : 00000000 806e2350 00000001 8f001880
>   $12   : 8f89fd14 00000000 00000000 65646f4d
>   $16   : 8faf9418 8f9cdc10 8f001880 8f9cdc00
>   $20   : 00000000 80c20000 00000000 80bc0000
>   $24   : 00000002 00000000
>   $28   : 8f89e000 8f89fd00 00000000 8082a914
>   Hi    : 0000006b
>   Lo    : 00008013
>   epc   : 8082a2b8 pdc_wdt_stop+0x1c/0x44
>       Not tainted
>   ra    : 8082a914 pdc_wdt_probe+0x404/0x550
>   Status: 11000403      KERNEL EXL IE
>   Cause : 00800008
>   BadVA : 0000008c
>   PrId  : 0001a120 (MIPS interAptiv (multi))
>
> Fix it by moving the call to pdc_wdt_stop() after we've set drvdata.

Disregard this patch and patch 2 - it looks like James Hogan beat me
to it :).  Patches 3 and 4 still apply I think.
