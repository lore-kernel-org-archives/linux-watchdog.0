Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50331 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbcDZQuE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Apr 2016 12:50:04 -0400
Date: Tue, 26 Apr 2016 09:50:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Perches <joe@perches.com>
Cc: Colin King <colin.king@canonical.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jiri Kosina <trivial@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: trivial fix of spelling mistake on "allocate"
Message-ID: <20160426165000.GA30901@roeck-us.net>
References: <1461611991-27328-1-git-send-email-colin.king@canonical.com>
 <1461648139.2726.119.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1461648139.2726.119.camel@perches.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 25, 2016 at 10:22:19PM -0700, Joe Perches wrote:
> On Mon, 2016-04-25 at 20:19 +0100, Colin King wrote:
> > fix spelling mistake, alloacate -> allocate
> []
> > diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> []
> > @@ -161,7 +161,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
> >  	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct jz4740_wdt_drvdata),
> >  			       GFP_KERNEL);
> >  	if (!drvdata) {
> > -		dev_err(&pdev->dev, "Unable to alloacate watchdog device\n");
> > +		dev_err(&pdev->dev, "Unable to allocate watchdog device\n");
> 
> Might as well delete this line instead.
> 
Excellent point.

Colin, please resend and just drop the error message. It is not needed
because an error message is already printed by devm_kzalloc().

Thanks,
Guenter
