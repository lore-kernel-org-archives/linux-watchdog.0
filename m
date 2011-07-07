Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.slb.deg.dub.stisp.net ([84.203.253.98]:10909 "HELO
	mail1.slb.deg.dub.stisp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752434Ab1GGPyt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 Jul 2011 11:54:49 -0400
Message-ID: <4E15D67B.2080405@draigBrady.com>
Date: Thu, 07 Jul 2011 16:53:31 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: iTCO_wdt: optionally leave watchdog enabled
 during restart
References: <20110706160744.4002.94920.stgit@bhelgaas.mtv.corp.google.com>            <20110706160936.4002.1846.stgit@bhelgaas.mtv.corp.google.com> <12164.1310053141@turing-police.cc.vt.edu>
In-Reply-To: <12164.1310053141@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/11 16:39, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 06 Jul 2011 10:09:36 MDT, Bjorn Helgaas said:
> 
>> If we reboot via BIOS, BIOS should disable the watchdog itself, so this
>> shouldn't cause unintended resets, even if the user interrupts the boot.
> 
> Yes, but didn't Linus say something about BIOS code authors being
> crack-addicted monkeys? :)

Yes as I said in a round about way in another mail,
one can't depend on that at all.
Some reset, some don't, some behave weirdly,
iTCO is unusual as kernel resets early at boot, ...

If using this, one would have to set the timeout large enough,
to encompass a full reboot
