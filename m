Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50421 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbdJZLfE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 26 Oct 2017 07:35:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id s66so2266521wmf.5
        for <linux-watchdog@vger.kernel.org>; Thu, 26 Oct 2017 04:35:03 -0700 (PDT)
Message-ID: <1509017701.29929.10.camel@arista.com>
Subject: Re: [PATCH v2 2/4] watchdog: i6300esb: support multiple devices
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Date: Thu, 26 Oct 2017 12:35:01 +0100
In-Reply-To: <20171025205557.GB30439@roeck-us.net>
References: <20171022170947.GA6997@roeck-us.net>
         <20171025153914.3467-2-rrendec@arista.com>
         <20171025205557.GB30439@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 2017-10-25 at 13:55 -0700, Guenter Roeck wrote:
> On Wed, Oct 25, 2017 at 04:39:12PM +0100, Radu Rendec wrote:
> > -/* We can only use 1 card due to the /dev/watchdog restriction */
> > +/* Probed devices counter; used only for printing the initial info message */
> >  static int cards_found;
> 
> Now unnecessary.

[snip]

> >  static int esb_probe(struct pci_dev *pdev,
> >  		const struct pci_device_id *ent)
> >  {
> > +	struct esb_dev *edev;
> >  	int ret;
> >  
> >  	cards_found++;
> 
> Now unnecessary.

This variable is still used for printing the module "greeting" message
only when the first device is probed. The code snippet is below, but
unfortunately the diff context doesn't include the condition that tests
cards_found (the line was originally there, I didn't touch it).

> > @@ -309,26 +313,33 @@ static int esb_probe(struct pci_dev *pdev,
> >  		pr_info("Intel 6300ESB WatchDog Timer Driver v%s\n",
> >  			ESB_VERSION);
> >  

So we should either keep the variable or drop the "greeting" message
altogether. Perhaps it makes more sense if we use it as a bool (rather
than a counter)? Something like:

if (!cards_found) {
	pr_info(...);
	cards_found = 1;
}

I fixed the other issues and I will submit a new version of the patch
series as soon as I get your input on this one. 

Thanks,
Radu

