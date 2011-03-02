Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:35674 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1CBQ1t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2011 11:27:49 -0500
Received: from localhost.localdomain ([127.0.0.1]:58574 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1CBQ1s (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Mar 2011 17:27:48 +0100
Date: Wed, 2 Mar 2011 17:27:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: John Crispin <blogic@openwrt.org>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110302162730.GA23666@linux-mips.org>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
 <1298996006-15960-6-git-send-email-blogic@openwrt.org>
 <4D6E286D.9050100@mvista.com>
 <20110302142933.GA18221@linux-mips.org>
 <4D6E5CA9.5090201@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E5CA9.5090201@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 02, 2011 at 04:05:13PM +0100, John Crispin wrote:

> Hi Ralf,
> > While nitpicking - there should be one space between include and < in
> > #include <blah.h>.
> >
> >   
> where did you see that ?

> +#include<linux/module.h>
> +#include<linux/fs.h>
> +#include<linux/miscdevice.h>
> +#include<linux/watchdog.h>
> +#include<linux/platform_device.h>
> +#include<linux/uaccess.h>
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +
> +#include<lantiq.h>

But that only seems to have happened to the code quoted in Sergei's mail.

  Ralf
