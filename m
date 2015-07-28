Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48290 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbbG2God (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 02:44:33 -0400
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using
 platform data
From: Jean Delvare <jdelvare@suse.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>
In-Reply-To: <20150728094643.GT14943@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
	 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
	 <20150728094643.GT14943@x1>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2015 18:50:27 +0200
Message-ID: <1438102227.24962.41.camel@chaos.site>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Le Tuesday 28 July 2015 =C3=A0 10:46 +0100, Lee Jones a =C3=A9crit :
> On Mon, 27 Jul 2015, Matt Fleming wrote:
> > +	strcpy(pdata->name, info->name);
>=20
> strncpy() is safer.

And strlcpy() is even better.

--=20
Jean Delvare
SUSE L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
