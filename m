Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916937F330
	for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238740; cv=none; b=gH0wx5ahO/E6Y4q2etb/e6+x4X1cEDyiAgnlwSAbRcbDGTbzwiY42Qbo38pS23MEg0q3PftSpWRziPT83ITlMp2Hr4hhhpVxOKIa/VMqRktjEUpdFbRqXq1hyGoa3RAdVCVQEMMdqT3fQCtMqiC+m6cKItQ2PlVLn8pCnHERDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238740; c=relaxed/simple;
	bh=VgQvPHOT1oD3vY67QiNLl36gc7zckXGTP+WmRIhRH+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SntJLLyrNJ1FaYQTbyzc/incHzGkc+RdtE9KyY2l+/giHbPnoBgigRUhCJeO18PIPgKQGkCRkZg/B6p5zVj0gwkb0MKC3gNIHEUkBIVYGvmTMyqoGCbgRrApa0ixXIgSOXDJQjF4dX3fC5HVsVoomOdhz2R+inYIKHGDftkCOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za; spf=none smtp.mailfrom=ffroot.co.za; dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b=ez62dkGv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffroot.co.za
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ffroot-co-za.20251104.gappssmtp.com header.i=@ffroot-co-za.20251104.gappssmtp.com header.b="ez62dkGv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so23033885e9.3
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Aug 2026 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffroot-co-za.20251104.gappssmtp.com; s=20251104; t=1787238736; x=1787843536; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ehmlMc2l8m1QEEs25SXGd4qRoiIIzqIj1MYNoMhCHwk=;
        b=ez62dkGvcdt4LWXPLdIyqlt9JLp9PXhSIGPekcVD42JpQoWIHBl4T7YsDGJImrLywO
         9k9T1N1OiNlJ9fNjk60Gd6aQNi0nrFxhE3efwOUTxLfLQCizTPDfLIumGsNJKyTD6sQj
         LgVZ/DAcYfkiCDFI8TTGlFtE5+/FrPF0BUYIUYyqM7gC1CbJJzVdtHfBE+Z1zr0NeR91
         FJncvBLQLeBnFfUdOO4bh/dH5IwyuAjAm8ttOuWH8nUJtVPOYo86XP6dxv9paBG1wB9o
         UMY5HL/AptP19ZSHWVn0G9neM7fdo2NCuCCosLnCUZ4WGtn6Lmt01KCOqV9uufPFFsb9
         aaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238736; x=1787843536;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ehmlMc2l8m1QEEs25SXGd4qRoiIIzqIj1MYNoMhCHwk=;
        b=OlPJww39zhFg9gA/rsv/U3ecV7YFAejikbdUOIplU0um6ZAoR6mAQp/cgsxk0n0+e2
         SJ+tct80dfMgli9+e4NL7npgqgIRsBvX4yXrzQKO9aZp5A5EViqZnrgBtT8cURhpzvqw
         EFEyS2Ca12OiIeSbHsFcIIpW1mFXr+il9WnwtzpTF7GYXE0x5bhCqNPrAlwlLsC6nXKE
         03P5rAzKmADDGGFx138KL7SCwmR9FjXcOiPhPh6vXcfr5d80kGh8JV/GHhl7wLUxl2QO
         4IrFomIRl+qpaod5Z7iYNm6auk1KGYihG23eEujhJY4fu54XpdYNDzO5uPxXswkwhPFy
         f/5Q==
X-Gm-Message-State: AOJu0YyKyezx2MMgCDw+b3Wr71wRMI9YoxuC5APzh5bkUK8DC3iqe9pW
	L8UJNhd/JaH3Zq7O4YvoBt5sWbZfXqWraqqZnmuHlZInPNrhHHFsCQVxFodytu4NkyY=
X-Gm-Gg: AR+sD12pe220bekGs8A9clK0EDZm448OxafhRVbUQhBU9wkh75dXeEUMpVbW4UqubCk
	RYiczUtPEw2aYfXK6oLOT9YBMUed6P8Mc6IzCrAkfQKsogluR8Wa9jRbpF8PvNoQzRHQwehX9Kb
	BIaJPVzSxGLV3wqfFPIgYIrga3X6MNAjrTMaOj1wWnOv/nkR7SMK+InuK6piEP635fgcPSQfwxr
	0hzBIUujaem1B+s8jpKlOgDlPKlq+Qt/KO0F6OMarAO2spcweVcCCvHYWFsPiNF2PBDBJP+RuSC
	rJ2L8fJwuLAdruqk9dLpRfx9P/oE2rlPQotjKAK+zRbZ9AZvUYtESVxJ32raZfDNkL/sYd2MVsx
	ogwNaJDtfTaoGzRizyC0kDUaoiCSwpi//vdEwAIZHa7Cl89yfNJs6y2ONf2B3xbXa8BeeY3AfYY
	CmOqWTFo0coi4GwJ54qNjEcSb4KLc4Iy+2kzGZ44QzMD6Naldi9+cfyJ8HocMlKP31JadmE8TNe
	cgRVSuZvV0=
X-Received: by 2002:a05:600d:8446:10b0:499:9eb8:a1d7 with SMTP id 5b1f17b1804b1-499aa1d0a9fmr189473705e9.9.1787238736286;
        Thu, 20 Aug 2026 08:12:16 -0700 (PDT)
Received: from dev-ag ([102.33.165.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b20bb2b4sm46102495e9.0.2026.08.20.08.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:12:15 -0700 (PDT)
From: Andrew Gaylard <ag@ffroot.co.za>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,  xt.hu@cqplus1.com,
  wim@linux-watchdog.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: sunplus: fix sp_wdt_restart spin loop and
 timeout
In-Reply-To: <d37eef21-a877-4500-a280-493e98c68701@roeck-us.net> (Guenter
	Roeck's message of "Thu, 20 Aug 2026 06:42:30 -0700")
References: <20260820125304.1583383-1-ag@ffroot.co.za>
	<d37eef21-a877-4500-a280-493e98c68701@roeck-us.net>
User-Agent: mu4e 1.12.14; emacs 30.2
Date: Thu, 20 Aug 2026 17:12:11 +0200
Message-ID: <sa6wltkx1v8.fsf@dev-ag>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:

> On Thu, Aug 20, 2026 at 02:53:04PM +0200, Andrew Gaylard wrote:
>> sp_wdt_restart() returns immediately after writing WDT_RESUME. The
>> kernel continues executing and the watchdog kthread could pet the
>> watchdog before the short timeout expired, preventing reset.
>
> Is this observed behavior or just an assumption ?

It's an assumption.

>> Add a spin loop so no other CPU can pet the watchdog while waiting for
>> the reset. Set the restart timeout to ~1.5s.
>
> I understand the first part, but why delay the reset by 1.5s ?
> That is a functional change which needs an explanation.

I had a printf there to confirm that it actually reached that point,
so I needed the delay.

-- 
Andrew

