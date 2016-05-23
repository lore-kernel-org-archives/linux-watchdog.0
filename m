Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34554 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbcEWUT2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 16:19:28 -0400
Date: Mon, 23 May 2016 13:19:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Boylston, Brian" <brian.boylston@hpe.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH] watchdog: hpwdt: update HPE maintainer
Message-ID: <20160523201927.GA16193@roeck-us.net>
References: <20160523133329.10075-1-brian.boylston@hpe.com>
 <57431A13.1040406@roeck-us.net>
 <CS1PR84MB011968DAA650E6408707CC1A8E4E0@CS1PR84MB0119.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR84MB011968DAA650E6408707CC1A8E4E0@CS1PR84MB0119.NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 23, 2016 at 07:38:46PM +0000, Boylston, Brian wrote:
> Guenter Roeck wrote on 2016-05-23:
> > Hi Brian,
> > 
> > On 05/23/2016 06:33 AM, Brian Boylston wrote:
> >> Update the HPE maintainer of the hpwdt driver.
> >> 
> >> Signed-off-by: Brian Boylston <brian.boylston@hpe.com>
> > 
> > A driver's maintainer is commonly updated in MAINTAINERS, not in the driver itself.
> > If you are the formal maintainer, I would suggest to add an entry for the driver
> > into the MAINTAINERS file; this would ensure that you get copied on patches
> > affecting the driver.
> 
> Thanks, Guenter.  I'll work on an update to MAINTAINERS.
> Okay if I leave my name out of hpwdt.txt then?
> 
Hi Brian,

hpwdt.txt is irrelevant when it comes to maintainers. In general I would
recommend to not list e-mail addresses in documentation, or anything else that
isn't static, such as the name of a driver maintainer. It just adds another
place which needs to be updated. So, yes, sure it is ok to not mention your
name there. You can list your name if you like, but please not as "current
maintainer".

Thanks,
Guenter
