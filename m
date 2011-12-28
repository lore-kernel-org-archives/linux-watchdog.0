Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:39719 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753017Ab1L1RMn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Dec 2011 12:12:43 -0500
Message-ID: <4EFB5BF2.3020600@xenotime.net>
Date: Wed, 28 Dec 2011 10:12:02 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Marc Vertes <marc.vertes@sigfox.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: linux-next: Tree for Dec 28 (via_wdt)
References: <20111228201806.d6de27fa2dbd9e3a3b7a2603@canb.auug.org.au>
In-Reply-To: <20111228201806.d6de27fa2dbd9e3a3b7a2603@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/28/2011 01:18 AM, Stephen Rothwell wrote:
> Hi all,
> 
> I got bored :-(  I also hate tree wide, flag day changes :-(
> 
> Changes since 20111222:


via_wdt needs a MODULE_LICENSE():

WARNING: modpost: missing MODULE_LICENSE() in drivers/watchdog/via_wdt.o
see include/linux/module.h for more information


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
