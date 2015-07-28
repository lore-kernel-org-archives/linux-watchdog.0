Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34914 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbbG1Jey (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 05:34:54 -0400
Received: by wibxm9 with SMTP id xm9so148342379wib.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 02:34:52 -0700 (PDT)
Date: Tue, 28 Jul 2015 10:34:49 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 2/5] i2c: i801: Create iTCO device on newer Intel PCHs
Message-ID: <20150728093449.GE2492@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-3-git-send-email-matt@codeblueprint.co.uk>
 <55B63B48.2040603@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55B63B48.2040603@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 27 Jul, at 07:08:08AM, Guenter Roeck wrote:
> >@@ -113,6 +114,16 @@
> >  #define SMBPCICTL	0x004
> >  #define SMBPCISTS	0x006
> >  #define SMBHSTCFG	0x040
> >+#define TCOBASE		0x050
> >+#define TCOCTL		0x054
> >+
> >+#define ACPIBASE		0x040
> >+#define ACPIBASE_SMI_OFF	0x030
> >+#define ACPICTRL		0x044
> >+#define ACPICTRL_EN		BIT(7)
> 
> If you use BIT, you should include bitops.h.
> Not sure if that makes too much sense here, though, without converting
> the rest of the driver to use BIT as well.
 
OK, I'll just switch to the existing notation used throughout the
driver rather than using bitops.

> >+static void i801_del_tco(struct i801_priv *priv)
> >+{
> >+	if (priv->tco_pdev) {
> 
> platform_device_unregister() handles NULL pointers, so this if statement
> is strictly speaking unnecessary.
 
Good point, I'll remove this check since it makes the code simpler too.

> >+		platform_device_unregister(priv->tco_pdev);
> >+		priv->tco_pdev = NULL;
> 
> Unnecessary; priv is going to be freed right afterwards.
 
I'll drop this.

-- 
Matt Fleming, Intel Open Source Technology Center
