Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AF4963C0
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001764; cv=none; b=e56+l37O51aboHB+JdY0KpgRnXlIz9xlB3j6HsLDM6+SND/2YATleNhusLXxU8Cy4c1opD/dT3tE6Ggb2xmSkRCMU4WUqt1pw31G6OD6+29Vg/tIPJnx5PsimwyfDBoFzO3wBXB1A76es9GbhEpJwGj0IaWew/1Q7H4yvKKUr+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001764; c=relaxed/simple;
	bh=Q8LfXyWD+ugHdVFd7y1IXdhd01kusDlV6qIfR2/k/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBizzJc5TTTkwFaGtKbONfH+ZDX7aRSeTdhPWHriBaVBuoahT2ERt/bslZsCIxLSQHt4fvdQ8RqqTf0EUmak1nBLBCZ2/Lcy+dr8dl/VkSQBWfu2OuZxiNnFKoPpoP8p6n17/ySqGsp3Tj534dktf978YonsjrKKPGg52+Vz0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7QrKbzp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7QrKbzp"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9672e02e05so874101a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783001763; x=1783606563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0jEyHCnJ5D4fHZToMgk1wOdXO1iLLZLCoZumGMTQYY=;
        b=U7QrKbzprSHaCGkddzu+Om7xjK2O7YPIdq/IxwNcFwkAG5sUyJyKgF6ABtVHqtgAjX
         7lj/IOu4308ZJ/JAX2ZlRSz0ffdn7ENwCYF7gX3cpq8cpeT3el1oSJdAbAh3eEJ/28FE
         s5N/tyIMMNlxDFooblIrIComGDUjqoOORwi/7exxV8ClBLNaz1n7EyQy2I7eE1T680Mp
         JRPhRs+NRLESOoWY7MtbPmn6cdqz2ztJ0CSK4LQEXzQCtXDKVVcf7i4QZli3yYwMHp8C
         oy+gfOPF2mDq7epU79ayyh7Kbc5dtTrJz8ArU0L5MrogdyWqHFg7h7p5Hz423856ycgd
         YrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001763; x=1783606563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0jEyHCnJ5D4fHZToMgk1wOdXO1iLLZLCoZumGMTQYY=;
        b=qRFT+riXUnp0VpupfpMyM4hhdgoXzAJQNeIG9j6QUK7ZYIs22iYZsdmYPsdQFz2f+O
         IG5+VaseBkoFbW5ibA3MolV1LkNtmnsXLVeJYe/yZBkvDiWcphsKTvuaqAfHHtyo9/7d
         0YUgGCi7gk8mQwhvhTHsE+Ifs+D1enelmZ6FVRS4Q4RSs4VbDRBQh91WOsjAPT8wGR4s
         n5GIsPEXArfSoGO8eEfolgc59ST6ci9uYg5GwQe5f5yk0QbriTjoBDp834/vdHbomtIS
         TjfJraaudCjDYqnPKl7rBzNWAq9KHvSjYcnSlxVS2BM0NvvQGZdE/oswOhGZlIDKAVoB
         HnOg==
X-Forwarded-Encrypted: i=1; AFNElJ9W+7GeObY4a24T8M52PlZiR9KXE+p3DenX2lAl3lDZFfERTXi7tpVQBTirKBDG7So/sb3vaq6Q4yowY+TQCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoP6jgMRDEWUHH09PWPRB9k3lwqpPgMWtQrkBg+I3BTcd3GFI
	LjwvAM1gNmvHA1cSq9+Y4KW04zzejsEAO6kQlVGeR3g8EVFCMeSe4lPT
X-Gm-Gg: AfdE7cnxCXpPx43Ym33x/D77OK/yddgZKSKaQq5T/a7cUw2q7eeOQu9nxDOFMEK77lp
	F/Tw4hf10+PVispXwo0+neubhuJKh79lHHPOnNpufTgPcYU5e7tY+K7hKMJa/wTI3gz8PiODn2k
	H3Q4wI/+OUtJQg932BoGi+P0PsvNbT8J1kPA8QStpiGDYeY9AZv7BV0Cxga84BxnFemC/s7FvT6
	xWAh5YY2XuFXYelVUtoWMUlgLD7uwfLZmCxtn1QCs1AzLWFbs8zkqvGSD0R0LI4B66rRwuf/ODF
	dAhXTZLfv+NKS5WfPZ9/tqBMyQ94Kbt7456C4kwQWItYDi1dn2hvMYGKWRv9uPsQJW2XmfLkaiI
	j5zhIXevdALk9xK5bIG641XypHcNwh90tJH1iZOeKSEJ56XEYmWRrygS/wS/RdsLu3KhhQICgjy
	UU4ihB/8iuvh1dEuDZtb56Sd+lUQ==
X-Received: by 2002:a05:6a20:258f:b0:3bf:8b8d:3151 with SMTP id adf61e73a8af0-3bfed3efa54mr7547366637.44.1783001762737;
        Thu, 02 Jul 2026 07:16:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f6bd050sm1315024a12.14.2026.07.02.07.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:16:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Jul 2026 07:16:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lukasz Majczak <lma@chromium.org>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: Use named initializers for
 platform_device_id arrays
Message-ID: <c8d7d052-6cd9-49ce-8db9-af6b84441165@roeck-us.net>
References: <22bc09d0c9c8dfe75a205b0a9ccc98ccfba1de10.1781622532.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22bc09d0c9c8dfe75a205b0a9ccc98ccfba1de10.1781622532.git.u.kleine-koenig@baylibre.com>

On Tue, Jun 16, 2026 at 05:25:10PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
> 
> For one driver drop the unused assignment to .driver_data instead.
> 
> While touching these arrays unify spacing and usage of commas.
> 
> There is no effect on the compiled arrays.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Applied.

Thanks,
Guenter
