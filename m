Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1048 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbaBLVol convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Feb 2014 16:44:41 -0500
From: Andrew Chew <AChew@nvidia.com>
To: Stephen Warren <swarren@wwwdotorg.org>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>,
	"rob@landley.net" <rob@landley.net>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"abrestic@chromium.org" <abrestic@chromium.org>,
	"dgreid@chromium.org" <dgreid@chromium.org>,
	"katierh@chromium.org" <katierh@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Date: Wed, 12 Feb 2014 13:43:37 -0800
Subject: RE: [PATCH v5 1/1] watchdog: Add tegra watchdog
Message-ID: <643E69AA4436674C8F39DCC2C05F76386319AB3891@HQMAIL03.nvidia.com>
References: <1391738086-29142-1-git-send-email-achew@nvidia.com>
 <52FBC2EF.4020000@wwwdotorg.org>
In-Reply-To: <52FBC2EF.4020000@wwwdotorg.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> > +static void tegra_wdt_unref(struct watchdog_device *wdd) {
> > +	struct tegra_wdt *wdt = watchdog_get_drvdata(wdd);
> > +
> > +	kref_put(&wdt->kref, tegra_wdt_release_resources); }
> 
> I forget why these were needed; they seem to do nothing.

The reason I did the whole kref thing was by following the guidance
in Documentation/watchdog/watchdog-kernel-api.txt, which says
that if the watchdog_device struct is dynamically allocated, then
one needs this.

> > +MODULE_LICENSE("GPL");
> 
> That should be "GPL v2" according to the license header in the file.

Done.  Thanks!
