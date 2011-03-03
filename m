Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42209 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1CCKPe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2011 05:15:34 -0500
Received: by wyg36 with SMTP id 36so880058wyg.19
        for <linux-watchdog@vger.kernel.org>; Thu, 03 Mar 2011 02:15:33 -0800 (PST)
Date: Thu, 3 Mar 2011 10:15:27 +0000
From: Jamie Iles <jamie@jamieiles.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: John Crispin <blogic@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110303101527.GE2955@pulham.picochip.com>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
 <1298996006-15960-6-git-send-email-blogic@openwrt.org>
 <4D6E286D.9050100@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E286D.9050100@mvista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 02, 2011 at 02:22:21PM +0300, Sergei Shtylyov wrote:
> >+static int
> >+ltq_wdt_remove(struct platform_device *dev)
> 
>    __exit?

No, I think this should be __devexit and the probe function should be 
__devinit.  When assigning the exit function to the platform_driver it 
should be surrounded with __devexit_p().

Jamie
