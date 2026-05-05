Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CE30170F
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986990; cv=none; b=jqdXPbQYhv9ID2zlg94dKXjJkU1+w7B4+Zv+4/br51cW9Mu51puwrMufJ1KVe3CZe8+pr+IXRuLD/ymK+ziAJzLs3WzoGYVw0AmJlDj/LEcr/9Oh3ikcNUvQUsraCyvMQJ6S9ZPHvLVOwd+seF5JAoqoGEKCIquxcvsQfKbyizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986990; c=relaxed/simple;
	bh=HHBBf63C55MZMSnlcu9etJXthxILRS+gIzX/cWZC9t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdPj/6TWoVbzU/RbZWLfiXsJze/HYX51ikjJwibvlHZgLMwidXa6M1r0KqSBv8dhOuikqwABDlw4W1o+YqqGfheht/CeY+J/s+YemH0DrdKk+ogXHM66TL0hbaTixFxcDQjiLrKZdMV74veF2tH8N0fgMSzW5IfjHKMPBU9jiUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4HQqU3a; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4HQqU3a"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f3c623322bso2028945eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986988; x=1778591788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c4M1Sxe8XfnwUoevaoL/2OztS3a3daovY1Nhqp4yXk=;
        b=T4HQqU3aeu9rTntyow+TeZcIgtfHktNYfdyfTuaIbUskk3Fg7tYNp5qgs+b9qUPrrY
         hVmK1GDRXbHmdFo2DQsS4prpcRpSM+lrJnzkOgvuqP5JXGl0VA6/+Z3N1BDaZH8iRqM8
         y+k+0uItveVpIVgmAYzPDgUsCPerJG54yahYquso9gG9YPONmJ8cA3g/ocRK1f0EZTut
         Mjhk9kQ64lnrL+tavqwpLnFiUkF8N842cM9FAeEqNVL+YtPdbmNfs5sWt8fN3Qc7n+dk
         koMD/i0EAQY7PmZUzX5wrf10uKeP4elrmu1fb56ML6c7iMPk7fGAO252w2MYYZ2PCX3+
         hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986988; x=1778591788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9c4M1Sxe8XfnwUoevaoL/2OztS3a3daovY1Nhqp4yXk=;
        b=gUXVQs82XXfmlCF7Ik+LCuEDJkzf2cc1Ni2fCfwqZbs5M52Xmj3RFZOYq3+5Zl/jzD
         Fl/DRfkLrm7dxSbrjCyi8FDhxLjLeoIrmgLuwG6HzUHbqPKRZSokncokiHwUXIWrOUQe
         1Z2nTqWMCRBcwvyayX7mvfJ2NhmcHUe7s/FiwtpHIlmHhq/ZmJELKwJevtCS/9ikD2Xp
         57IGFwcYav/do1tLX8KdosBXLjQNpHVyeR5gEw9y7gmBzqgIiXrBVY/ima61uAG4cRc0
         RGK7S8QDUb8aCkC3Qa5FQLilVvxHGhn4KbtxjeTvAM+DK0vue58yUURIfxP3dB9WmBtI
         pChw==
X-Gm-Message-State: AOJu0YxU7ZP7sTO94rpehqHCVZMooVcs7ui0sQ5YK5mNZx9rWv8WYcve
	cMGs0ANi4A98LBI5gMTCvFibkwNqah3ZeiLkDvwpD3WfkoX5ZVGBKqnP
X-Gm-Gg: AeBDievqqzKtknjgJLdH121gD6pe2BqhQHwkTzdhQZYRacC0iv7hbyKLxYNyHfkJZKZ
	4bobTRr8zzqtFA9eWt1pGWScYBxeERRHUjia1Qwd0slsnmii6jwGDtx9iZnjizbyay9uWlftiIV
	xBvCov2sjqSmtKt8g20NZXowEIymPYEEqm17hd7j7l7P3xOJzvoR+UPmzpk+L3P1OuCCn0CS2zL
	4+P7c1M1tD3ip5eAPIXQmR7ufrIxIUhDnU5KthPjhSSuR8ZUawZd0MSajLWKpcdaWc59FIxprJb
	QWvWJai5CfKGS5MnsAcyM9zhvcXZpJByh2DJMTLt81/tGii1aQ9VVUhVoyZDjDBE6r+Qqo4ckXC
	pe9yQS8CoZNIFPxT2pUIKYDblrmzsKo/kwCcNFt6N+vHOtaNK/lfMOHK3gUP0glmght91R2DJ+y
	x3gr9aB7puRDyLCyNsWMCBf+IoozsMQ7z0EgyDde0mGddr7D+/1du5I/wwXQ==
X-Received: by 2002:a05:7300:e68b:b0:2e6:e868:4f38 with SMTP id 5a478bee46e88-2efb7ad902emr7357996eec.3.1777986988349;
        Tue, 05 May 2026 06:16:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee393578f1sm20977783eec.13.2026.05.05.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:16:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:16:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-watchdog@vger.kernel.org, stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: Re: [PATCH] watchdog: s32g_wdt: remove incorrect options in
 watchdog_info struct
Message-ID: <e1950f20-3b1f-4989-a360-d330949757f5@roeck-us.net>
References: <20260505024409.60301-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505024409.60301-1-enelsonmoore@gmail.com>

On Mon, May 04, 2026 at 07:44:09PM -0700, Ethan Nelson-Moore wrote:
> The s32g_wdt driver uses two incorrect constants in the options field
> of its watchdog_info struct. This bit mask should contain WDIOF_*
> constants, but the driver uses two WDIOC_* ioctl constants (in addition
> to correct WDIOF_* constants). This causes many incorrect bits to be
> set in the bit mask. The functionality indicated by these ioctl
> constants is supported by all drivers using the watchdog framework, so
> this patch simply removes them.
> 
> Fixes: bd3f54ec559b ("watchdog: Add the Watchdog Timer for the NXP S32 platform")
> Cc: stable@vger.kernel.org # 6.18+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Applied to my watchdog branch.

Thanks,
Guenter
