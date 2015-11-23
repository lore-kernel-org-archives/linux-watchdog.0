Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58319 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754916AbbKWN3q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 08:29:46 -0500
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: gpio-wdt: Rename notifier to reboot_notifier
Date: Mon, 23 Nov 2015 14:29:39 +0100
Message-ID: <1928403.ZSnPjExYYh@ws-stein>
In-Reply-To: <5652A51C.2030509@roeck-us.net>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com> <5652A51C.2030509@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sunday 22 November 2015 21:33:16, Guenter Roeck wrote:
> On 11/09/2015 01:55 AM, Alexander Stein wrote:
> > This is a preparation before adding a panic notifier.
> >
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> 
> Fyi, we are going to have an infrastructure change which will make this patch unnecessary.
> 
> See http://patchwork.roeck-us.net/patch/451/ and http://patchwork.roeck-us.net/patch/452/
> for details.

Both links are not working for me. Give me a 404 error.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

