Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2C4915B5
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343995; cv=none; b=DEGlD1VmyYp3tDwCpOQwD019xO+CdMU6r5dTr0olgdTigmJ5V780GLZTtS00Y7Gr8HFhxveUV8yaaiY0+5afsNNUvzpphWs6gLfdA+YqTPi3BjmvAUIFv+hUvVqTFlsttRkTRORsrNIqGoaEoFUO5pg5491zpdY6/vsCXiPDlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343995; c=relaxed/simple;
	bh=A/dFqGFagsOa4cbDQX2zLj+dKAg085FQZdmwPQWYu/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObhhBXeieYQpSLogtUpBf+QgHJUQ4mMpUJd5GVHmKLqda0LTPEwtNK8ABZ3WXnJXzFeadBr7z7rlFqs5fxQwwq1dumE0mx10XVI+avnJhflsVv9BQ02XY3GitVnS6xj/gVWxbE5LLgpc0sDpvlXIlD0fEng9MEBk8JIQv9H1YbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW9nM4fx; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW9nM4fx"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b5b07ec78so501876a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790343992; x=1790948792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KjQUlVePIHKvlpRxk8hYR0PeRg7AQzrum5C8cdG2ps8=;
        b=bW9nM4fxMaOR+wKzv2VGqXqd6XavRqbI/zCwCQ/Axs0KiCklO1musqC1VwHFluRPf9
         N6Wq11V9A2M0XX7sTtohHeGSKbLbYLxGlG8iofc0gKTgxqIGH17lEItc/I9F1NLse7Z3
         D5ZiwKEeLXHOPVMDKSAhpCMiL4JN5WUgmCyd+iky1L9ZRcGA5qEYiTI+fUYXlkbyI10n
         GkB0NT85uomUyuc+hR7Zys1s4/ajLRMKAhTsh59s+gcqK6Wrv4/u/BP4LtRTEGX1cYYA
         YGJf50rnOORkhgNyaA9DxGyQF01cERaOkgzJ2sghTI84YvKnixuVqzBei2t1PlcGtU0n
         vwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343992; x=1790948792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KjQUlVePIHKvlpRxk8hYR0PeRg7AQzrum5C8cdG2ps8=;
        b=1iFsLUYLoHo5wU9i0pKRqkY5CmAWM1YY0AGTiK1tIMdm2c17KpWZcDD93gDfZoMXTC
         ATHLNjtVibrYUo/tJN4zeR71bBq2MLp93RjSrGxrRIKlDYxRa8RoluzrLOiCz2AqmCb0
         GCz1uwy+Ycm4gehbU/KXkt3sM7OpVnl5VW6+zK9GaPdSjHdM2TPQ5exqf6y3RxbV0Jcq
         j2m3dszuhvjy0lbkxflPjoivd4w10tEToL/AXa3CpSeiLtQAlzQRVEqsanh9aK+LgYze
         cFIBaXe48sKtdb1VnljvsplvCokj6ASUEPW4SHCgHTUJJ3kagY5R4fsyHiOP4hSGKtx2
         y4cg==
X-Forwarded-Encrypted: i=1; AKwUvBzHaQ7jAoWZwlvDfRfA2VjR9Cnum+GwGmDUta24rliNsWrfipIEyuUHBqSOTwM3iMdMZ2aS1HrlsPEWMSE+Xw==@vger.kernel.org
X-Gm-Message-State: AFuF++nWvTue9LYPn0q7UNkIGOo5bGREutz86hUWN6PukEueOdMhLTG+
	AUgr0xnqP8h08aYwla24/cj7ccyCtK78FUpMf3/9v6idOyKZlei3lHOcrHLtnu9a
X-Gm-Gg: AYBFou24LcxeZUZoaWO5WrIFXLKOND5T7/hm2tnxmLygBdVp3kBRuhQTBGu01dZnJ3w
	tWD3X8bVyuZgS6uY2CbM/7dBTIWGIQ/tLuCkacqTZvcCFKEeBV9q172qqhPFle0VO9cNZTQGQN3
	E3BssuC3H4TKDADPKqGZfPjqqKAV1j1S2wr8BBi36oZWD3MZiJFNNAAgr5jXjfgqJ4RYoPJl3A/
	ONNSgTgOqKiv99DdOoW87ijdjzWQwNDxW5ZmTRzUMOFUolas1TeoEDXGZ95ma2L1jou+ww6LAI9
	DdIcI6EefTZRVWZ7Mw4DauPWkkla6bdQM13Hdk/qTMLqxAAzJS5rPJJc1QyW7Zir6ll8wphJNSu
	oSWsSK8BggthtyG9ZvoADx+IHZFvt9hm7xOdlM77tsV8OlLsLZG0r3jPDz0RUWm78WCRZwP/O+K
	AAUVd5Q9zgN3PINNDc1Zmb6r4HF7Yv1dXo4GZB6g0zy6JLsS22jjetNf8XswKcn40DZ94+qSNER
	H1u00EuULSw
X-Received: by 2002:a17:90b:48c1:b0:3a0:7d5b:8d55 with SMTP id 98e67ed59e1d1-3a098571114mr5432759a91.8.1790343992452;
        Fri, 25 Sep 2026 06:46:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm4556661a91.1.2026.09.25.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 06:46:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 25 Sep 2026 06:46:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: sashiko-reviews@lists.linux.dev
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 08/11] watchdog: sbsa: Handle IRQ probe deferral
Message-ID: <d9102e7e-a69a-4ad5-aa38-c2cbd9d98496@roeck-us.net>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-8-2c62125d0085@kernel.org>
 <20260925075726.B0A6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925075726.B0A6B1F000FF@smtp.kernel.org>

On Fri, Sep 25, 2026 at 07:57:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] watchdog: sbsa: system reset due to unserviced watchdog on probe defer
> --
> 
> commit 82d6b6d0cf8ddd44758931db5360cd8439795f6f
> Author: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> watchdog: sbsa: Handle IRQ probe deferral
> 
> This commit handles probe deferral when mapping the IRQ for the SBSA watchdog
> by returning -EPROBE_DEFER.
> 
> > diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> > index e04d42cc7774d..f4491409caf5d 100644
> > --- a/drivers/watchdog/sbsa_gwdt.c
> > +++ b/drivers/watchdog/sbsa_gwdt.c
> > @@ -352,6 +352,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
> >  
> >  	if (action) {
> >  		irq = platform_get_irq(pdev, 0);
> > +		if (irq == -EPROBE_DEFER)
> > +			return dev_err_probe(dev, irq, "failed to get ws0 interrupt\n");
> 
> [Severity: High]
> Does returning here during probe deferral risk an unintended system reset?
> 
> If the bootloader leaves the SBSA hardware watchdog running, the driver
> correctly detects this via status & SBSA_GWDT_WCS_EN and sets
> WDOG_HW_RUNNING.
> 
> Because we abort probe registration here, the core remains unaware of the
> device and will not ping it.  If the deferral period exceeds the hardware
> watchdog timeout, won't it expire and trigger a reset?
> 
> Previously, if platform_get_irq() returned -EPROBE_DEFER, the driver fell
> back to single-stage mode (action = 0), and successfully registered the
> watchdog, allowing the core to immediately start servicing it.
> 
Looks like a valid concern to me.

Guenter

> >  		if (irq < 0) {
> >  			action = 0;
> >  			dev_warn(dev, "unable to get ws0 interrupt.\n");
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=8
> 
