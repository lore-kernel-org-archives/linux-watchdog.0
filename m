Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42740 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbEARcN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 13:32:13 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoEnM-000DbO-Gl
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 17:32:12 +0000
Date: Fri, 1 May 2015 10:32:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Timur Tabi <timur@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
Message-ID: <20150501173209.GA7712@roeck-us.net>
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
 <5542F33D.2020206@roeck-us.net>
 <5543A6E9.1090203@codeaurora.org>
 <5543B7D0.706@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5543B7D0.706@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, May 01, 2015 at 12:28:48PM -0500, Timur Tabi wrote:
> On 05/01/2015 11:16 AM, Timur Tabi wrote:
> >>>+    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>>+    if (!res || !res->start) {
> >>>+        dev_err(&pdev->dev, "could not get control address\n");
> >>>+        return -ENOMEM;
> >>>+    }
> >>>+
> >>devm_ioremap_resource already prints an error message if res is NULL.
> >>And res->start can not be 0 unless there is a severe infrastructure
> >>problem.
> >
> >Will fix.
> >
> >>>+    data->control = devm_ioremap_resource(&pdev->dev, res);
> >>>+    if (!data->control)
> >>>+        return -ENOMEM;
> >>>+
> >>>+    res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >>>+    if (!res || !res->start) {
> >>>+        dev_err(&pdev->dev, "could not get refresh address\n");
> >>>+        return -ENOMEM;
> >>>+    }
> >>Same here.
> 
> So I must be missing something here.  I'm only printing an error message if
> platform_get_resource() fails.  I'm not printing a message if
> devm_ioremap_resource() fails.  Are you saying that I should not print an
> error message if platform_get_resource() fails?  What's wrong with that?
> 
devm_ioremap_resource already prints a message. For this reason, elsewhere in the
kernel the check for !res before calling devm_ioremap_resource is being removed,
leaving the error handling to devm_ioremap_resource. I would suggest to do the
same here.

Guenter
