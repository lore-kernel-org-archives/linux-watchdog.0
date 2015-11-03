Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:53536 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbKCOgm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 09:36:42 -0500
Date: Tue, 3 Nov 2015 09:36:38 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
Message-ID: <20151103143636.GA8350@localhost>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <4911273.Q2mbQ2gvpn@wuerfel>
 <20151103101217.GE3503@x1>
 <5597828.MPo2kL1TSa@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5597828.MPo2kL1TSa@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 03, 2015 at 11:48:38AM +0100, Arnd Bergmann wrote:
> On Tuesday 03 November 2015 10:12:17 Lee Jones wrote:
> > > 
> > > I think a 'buswidth=<16>;' property in addition to 'compatible="syscon"'
> > > is more in line with what other subsystems do.
> > 
> > Perfect.
> > 
> 
> Just to clarify: I just checked the other DT bindings and it should
> actually be "bus-width", not "buswidth".

Actually, I need the set the three following values of regmap_config:
reg_bits, reg_stride, and val_bits.

I had the following mapping in mind:

@@ -69,6 +70,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
         else if (of_property_read_bool(np, "little-endian"))
                syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
 
+       ret = of_property_read_u32(np, "reg-bits", &val);
+       if (!ret)
+               syscon_config.reg_bits = val;
+
+       ret = of_property_read_u32(np, "val-bits", &val);
+       if (!ret)
+               syscon_config.val_bits = val;
+
+       ret = of_property_read_u32(np, "reg-stride", &val);
+       if (!ret)
+               syscon_config.reg_stride = val;
+
        regmap = regmap_init_mmio(NULL, base, &syscon_config);
        if (IS_ERR(regmap)) {
                pr_err("regmap init failed\n");


Would you prefer other property names, like "reg-bus-width",
"val-bus-width", and "reg-stride"? Should I prefix them with "syscon,"?


	Damien
