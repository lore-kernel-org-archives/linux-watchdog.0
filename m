Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50444 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbaCGPas (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Mar 2014 10:30:48 -0500
Subject: Re: Watchdog drivers and device driver model
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog <linux-watchdog@vger.kernel.org>
In-Reply-To: <5319D99A.50003@roeck-us.net>
References: <1394199268.4376.50.camel@chaos.site>
	 <5319D99A.50003@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 07 Mar 2014 16:30:46 +0100
Message-ID: <1394206246.4376.53.camel@chaos.site>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Le Friday 07 March 2014 à 06:37 -0800, Guenter Roeck a écrit :
> On 03/07/2014 05:34 AM, Jean Delvare wrote:
> > If you need some background: my customer needs to unload the native
> > watchdog driver and use the IPMI watchdog instead. So they need a
> > reliable way to figure out who is handling /dev/watchdog so that they
> > can unload the right module. This is rather difficult, costly and
> > fragile with the way things are currently implemented.
>
> Another solution in that specific case would be to convert the ipmi
> watchdog driver to the watchdog API. Then it could be loaded in parallel
> with other watchdog drivers. Of course, the naming problem would still
> exist.

Not sure if it would help. If both the native watchdog driver and the
IPMI watchdog driver get loaded automatically via module aliases, it
will be racy. Only one driver can own /dev/watchdog at any given time,
and the use has to decide which one.

-- 
Jean Delvare
SUSE L3 Support

