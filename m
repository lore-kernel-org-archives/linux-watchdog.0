Return-Path: <SRS0=sicv=VT=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6EC7618F
	for <linux-watchdog@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEAE2199C
	for <linux-watchdog@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="lK6Cr8CV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfGVRlf (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:41:35 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:46293 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfGVRle (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 Jul 2019 13:41:34 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id A83BC3A33C; Mon, 22 Jul 2019 19:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1563817289;
        bh=uF17hmBgsI2wbHlO9ZTrAKctKvzxjR/qB8WDw+8daZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK6Cr8CVkxZcyx1G8RMXGFHzUDo0igp7fIVJ2eq8rolVmIZ3xEzFR0ZaU4Gzz2uJ6
         VXnYXFwLjH6XtFkTe2ekSQupF6rkz7fFfUKm8zqJFWYIpFzp3FcWInaNIMPyod5uRv
         k/6MccfRsLaUGZr21sg1uZHnwh5gNWOmvZ+gZkGOyCUSBOG407X/JkxlYjHe67Zntq
         PC0/5K1Ih3e5MEK2f9jby/wHfdGbZZ2wi+shXy8UWf7FoiTMZWBM2N9eNY2KQT9azW
         GBSKlQS1rN0wkTQVDfn6ECBi9Y6fQpWoIFtRh/CgihZWF+zmlKc1l5A75HIPJTUceL
         o1hyezFGzKR0w==
Date:   Mon, 22 Jul 2019 19:41:29 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org
Subject: Re: iTCO_wdt on Intel NUC
Message-ID: <20190722174129.qzlg5exwx5ns3fkw@valentin-vidic.from.hr>
References: <20190721203047.3jd6slko6guz52fl@valentin-vidic.from.hr>
 <d2f78a10-df19-9922-565d-b0ed6fcacb67@roeck-us.net>
 <20190722045557.tndjp4hnpngvlaql@valentin-vidic.from.hr>
 <20190722154549.GA5166@roeck-us.net>
 <20190722161026.3bzxwibivomuysqf@valentin-vidic.from.hr>
 <20190722162152.GB8122@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722162152.GB8122@roeck-us.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Jul 22, 2019 at 09:21:52AM -0700, Guenter Roeck wrote:
> I suspect that the driver may be instantiated from two locations
> on your system. On top of that, there is also wdat_wdt, which
> instantiates a watchdog device through ACPI. Overall there are lots
> of areas where things can go wrong with this driver.

Yes, it seems to be related to i2c_i801 because that tries to
load iTCO_wdt:

# modprobe i2c_i801
[40450.070587] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[40450.070652] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[40450.072919] iTCO_vendor_support: vendor-support=0
[40450.073485] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[40450.073546] iTCO_wdt iTCO_wdt: can't request region for resource [mem 0x00c5fffc-0x00c5ffff]
[40450.073578] iTCO_wdt: probe of iTCO_wdt failed with error -16

-- 
Valentin
