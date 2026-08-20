Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C90258EE9
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241940; cv=none; b=NuzTGcZNWoszVLu4rZj3xs4va+V38iPFwXxKJ2ei61WekdybkrBQ+1TfhyzGezoSCutKTm7ltBZvu5needhEV2jivAPsVMQI3SSsOeQvziOUwNnC8MDTQQzfNwSaI2vrKGvmNUmtIAz1KB+PNx4rSDTHYOWEo8MlBhVfdvtUvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241940; c=relaxed/simple;
	bh=Luox56VNP/Hyos7DtMb7JrSGLPoeYG9ablQar2pWyVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epYguFzqXi1HMMnI5nceqJX+0G56ekw2B49hvpaSS5qwbCCjnkEEyoeIE0TBBU7XG2sURL5XgBMbmJAy4dn6K7rPPT3Sms5PMkFHMx5MUMTGFXH0+pYwBP+FNnfr2Za6uNbklVSun0yHemyR7gKHW31ObP+d1h0L5GQKm1Y2ZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWS6RK30; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWS6RK30"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so61788a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787241938; x=1787846738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=77AfpPuYjDKx/5NnMNRhA3lWjDKSF1kXAbYDxJAMzsQ=;
        b=PWS6RK30t7BdWpYb10eulA72XK3cQCPPfE35BdSw2ZlX4tmO6oVtyDd3QOxAlUC4CT
         0bDl2vqcQjOxMA9qQeRNuwEXkDLHS7Hb1AvCJAPpxiFsweATtCuBpPcQ5QE3ob5DJ8Bh
         5KPd5VgY5m3dAaB87il+EGJS5AEDxz3JmeNax2xlg+YSe97YXMBBYQrp85m88sc96HVe
         IEvPjFhACwgGZFGcwtSdAzleXag+UVHSSL6TbheJGeIOXEYMoB/z6uMOFyxP/qzNXpHO
         bbPwjmt9GfEXB5/QDpyXfb6gmLMJZxHa3MTNPsh/AsuyuLDMlBlmHmPkdYuI1tlWmsi0
         BG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787241938; x=1787846738;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77AfpPuYjDKx/5NnMNRhA3lWjDKSF1kXAbYDxJAMzsQ=;
        b=eRHcKSoI0xn67WYyulqhD79A1B4EXFvx3XvYRS0U9fgkPWLDOcwpiiqCp5IlkPXDlb
         2RDHXGaZ2O6/pBr+Z9Ag3ZFtd54w0fnxPilyQ0L8xTThpQ1EY9PvNQMcbK7CwOBuKBbx
         X0G7X2ds3LIrL9hRZ2KQj3+KLTIvMMigKstDCqvZ6uZXW2AKfhREuh6rLEXhcDCGHqfS
         8HACU5wPCQ989S8wYJjJjF/kay2QyH0gffdyTwNwZW9I3aX9KAZ8kMiSL0+BQ4m2OlRr
         lbrKnEk/sLBTvGbnTJawksmgCZL9FrGJjSHf/wvg1YVcE+PUU81GR3M2j7CBcvvlAS7W
         sA1Q==
X-Gm-Message-State: AOJu0YzFb5MHk5OvaHlmtjCFIaWGWWXpSPl2rQw7e0hKBT9DThCfgTND
	l/aFWxzSyoafirdnPFgskCsMP6KTyKhZGf32Ez82jyZ1onEBEPmhX6Z9
X-Gm-Gg: AR+sD13hgAxbH3G7fcunpFcdq+4y2qLAeNZCawl5C3ULyUX3P1lekcyP/Z5d20KgJT/
	oWTgaQHg4aI7IjJLFUAeewc5b3AgBMWjn9q1ptRp5omp+DcCDGppq5MQn8i6rf7wVhqLD/IrTDl
	DrQcHtFGuSPBvLw5ZncAD3/7DzNZZnDRSBetZDvOrlX+jDLuU6HlT2LWXAx6w6OG6aaR04smrYW
	kQ9SOEpHl+aY2Mil66L2zyuc0ZJfMOimV9YX92xlpeKezK8DsxXM1nFedzfQP+7K5yQg6CjcYH5
	ife2MuRkaj0Slten/ou0t1Keb8BBQdpoh9QTxFLmfmV9sm6ddIZAqybks8DvxuUq/M6T0iMq8nG
	i3nA4139m5CkdBfc+5mEHDM3bANFJSbFpaJJ2bEH0tU+AViiaIMO/Y+vgvJT1+0h6bETu/zRS7v
	00+NDaI8ya0ZvGcJ0NBCZFfMWW/vJvvi65xoSoXGWqSHuxeAlA4OFHaLSeISrI/emla+z7PmJMH
	g==
X-Received: by 2002:a05:6a20:e607:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3cd01213941mr29600286637.15.1787241937892;
        Thu, 20 Aug 2026 09:05:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf1970b0sm18397918eec.29.2026.08.20.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 09:05:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Aug 2026 09:05:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Gaylard <ag@ffroot.co.za>
Cc: linux-watchdog@vger.kernel.org, xt.hu@cqplus1.com,
	wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunplus: fix sp_wdt_restart spin loop and
 timeout
Message-ID: <5f3534be-ce81-4c16-8391-c42b3f880b57@roeck-us.net>
References: <20260820125304.1583383-1-ag@ffroot.co.za>
 <d37eef21-a877-4500-a280-493e98c68701@roeck-us.net>
 <sa6wltkx1v8.fsf@dev-ag>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sa6wltkx1v8.fsf@dev-ag>

On Thu, Aug 20, 2026 at 05:12:11PM +0200, Andrew Gaylard wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
> > On Thu, Aug 20, 2026 at 02:53:04PM +0200, Andrew Gaylard wrote:
> >> sp_wdt_restart() returns immediately after writing WDT_RESUME. The
> >> kernel continues executing and the watchdog kthread could pet the
> >> watchdog before the short timeout expired, preventing reset.
> >
> > Is this observed behavior or just an assumption ?
> 
> It's an assumption.
> 
So you habve no idea if this is a real problem. I am not going to apply
this patch.

Guenter

> >> Add a spin loop so no other CPU can pet the watchdog while waiting for
> >> the reset. Set the restart timeout to ~1.5s.
> >
> > I understand the first part, but why delay the reset by 1.5s ?
> > That is a functional change which needs an explanation.
> 
> I had a printf there to confirm that it actually reached that point,
> so I needed the delay.
> 
> -- 
> Andrew
> 
