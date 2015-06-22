Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43000 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753723AbbFVHuB (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 03:50:01 -0400
Date: Mon, 22 Jun 2015 09:49:58 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] watchdog: mena21_wdt: Fix possible NULL pointer
 dereference
Message-ID: <20150622074958.GB2899@c203.arch.suse.de>
References: <1433240726-7031-1-git-send-email-jthumshirn@suse.de>
 <556DB350.4000803@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <556DB350.4000803@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jun 02, 2015 at 06:44:48AM -0700, Guenter Roeck wrote:
> On 06/02/2015 03:25 AM, Johannes Thumshirn wrote:
> >In a21_wdt_remove() we do a watchdog_unregister_device() on struct
> >a21_wdt_drv->wdt but never assign it.
> >
> >Also move the dev_set_drvdata() call in front of the watchdog_register_device()
> >call, so it doesn't look like an error.
> >
> >Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> Good catch.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Guenter
> 

Hi Wim,

Any objections to this one? Do you intent to take it for 4.2?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                       Storage
jthumshirn@suse.de                             +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
