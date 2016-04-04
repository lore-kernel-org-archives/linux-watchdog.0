Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52277 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642AbcDDOIK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 10:08:10 -0400
Date: Mon, 4 Apr 2016 07:08:12 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	dirk.behme@de.bosch.com, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/4] watchdog: renesas-wdt: add driver
Message-ID: <20160404140812.GB10556@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <1459511786-4286-2-git-send-email-wsa@the-dreams.de>
 <57010C13.7040007@rempel-privat.de>
 <20160404104508.GA1383@katana>
 <57025C5A.2060704@de.bosch.com>
 <20160404123654.GA2983@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160404123654.GA2983@katana>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 04, 2016 at 02:36:54PM +0200, Wolfram Sang wrote:
> 
> > we are using it. So it should be implemented in this driver as well,
> > if it is not supported by HW, then we will need to use second timer or
> > watchdog for pretimeout interrupt.
> 
> As I said, I have no task like this assigned (and no personal interest,
> too). So, you'd need to do it yourself, hire me, or request this feature
> from Renesas (and hope that they pass the task to me ;)).
> 
Sorry, I lost the context here. 

> > Please correct me if i'm wrong - module parameter is a way to ignore
> > kernel config. For same purpose, to disable wdt at runtime "magic 'V'"
> > should be used.
> 
> I have to admit that I don't have a specific use-case, I just did
> general support as requested. So, I followed the style that basically
> every other watchdog driver has this parameter.
> 
I don't understand this one. Unless I am missing something, the module
parameter is standard, and magic close by writing 'V' is supported.
What is the problem ?

>From my perspective, for v2 of the patch,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter
