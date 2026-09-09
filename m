Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6747F788
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988625; cv=none; b=kFAriwC6R0WaP+ZEo70edYJasNot9yjv/mR68LYFxSelwUjk6D5C4XAHqL+O+QRix27N+gOR4R8VuKqzIr57duCFI40k1kCA78A9xNHHS1gpPS6PXDuOcvfjvaVRMqQbXIV/CgK6P4JTPHtf3Fh6tQkGWlwYU4NtTfAJewcUfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988625; c=relaxed/simple;
	bh=k1jSlvLGd1N8T2+/PFzEq4zFFneeum+jSHZrxSX2XCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1RG9pGlcsNqVQtZvaP1rjB0Zi1BVWsfPIZMFHvAvUyYK7YYMTFjDmX1fj4YnmXu4SDTBSHPpkDC96+8vC9tjftFZ9TKoUZcDGHKUnbgnclh9GR70WNnKTM0KgNmkAEke7YeSGrUap1VpswfPhzyup+BxAY8mmIBZywR23xSXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIJxdIwH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIJxdIwH"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so9965236a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988624; x=1789593424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=elx9aBOBNV+MHhj5RKuekYxX8HXb64ybgFqVDYtbhUM=;
        b=lIJxdIwHBPRsVBaOKtYH0adk0MPEGgT9Z3uZSfrBfLR++PceRNJQyBL6+CbNrxxBcg
         s+cv93CIFt2eFH4+rvQD/2poV0lgWa/I3lJhqgLBLjHpDOYyHkCLxy2o6ajhbS7lPMX4
         IsGUaPrnSj9KqkRVrfASsFOLP37Lf8wb05NOjW5KPQnc4pD87dMwdt4g11H5PzQL1nLw
         GIHPSXqsMt5sRGGHZpv4dvga8GSUsBt9OFqQFnYA+9yTIoP3ABc/ZWE3PqCU05CKp7Rn
         a/o3PAWcPW0Jp6UVRaFy+SE8uQk/9sozP16m4KuIhv6prZwXqlQIFwXvjo626d0ZU5ns
         LBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988624; x=1789593424;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elx9aBOBNV+MHhj5RKuekYxX8HXb64ybgFqVDYtbhUM=;
        b=gdLV6rq+nw4HaSs5b6e35FZYpzBtNhjmTdZfFB0wzpHDFXkQwCuAs4WAyms3Gp/JyB
         N3NKN5HYla56eCRzbjJ0DYC0G1VzC7SXq5Qpj5CeH57eqMPWMTZ4z5xQTeV9Ek5VK00l
         8zdbo5tcmJF7STgCFdxcnN3grp6iIuEKeLwGe/hJxd1JHMIG5zTv5k6TDrD25CEKFTYi
         Nl9qDtOIXYtEhx6YffntJbz2Bs+4JSxo9V4G+OrG28twxnB4aRoWt46f/D+Yt/CD5nPM
         5Eew7TjGDl7DKpdvOzkqrCsmbyS2+MOVHby7EJnS64oL08YAbBzLC0O/sdTk9KhlH3WM
         YUqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDlYtu4UwS8rHwINooW+Xx8RM73bO9YU4QqmgbPl1suvHZPm5GHqkkRRgbKnyyBaeqSueOMULpqy+Q9Ts12A==@vger.kernel.org
X-Gm-Message-State: AFuF++lPYhq26BBhFbosq2LoEJcxHQU/HRzBfJPzUMNtOtsiOqX0nbVq
	z2y7Ew+rJNs/mWK9OEtOw8xh9Lr571MKxOxx4niQ8VIV7yDIMvH51Nco
X-Gm-Gg: AYBFou0UvGaXE8PsFEBdLFAqXMHOI+KWbOsSNc+kjw0sulYjCwvyPoEoBX0HFLSRpl6
	nWzpQkeYr8w1imn2daEphhF2Emn38PQt3jOtxhTWJ6u1aQiqmiyfHCT6emmiBKsjsjRwzkChUvf
	4qyuwdr4Kl9xiI0aTLfZpnheM/0MmytdVpuILlJ5svRxVEe8UxuqUAOvTsM96gswwRikeWtCusU
	KRh4gP3/Su8d4iIze6tY3QWac4YQhyqBKCuTICItZAB3Qwh/881LXZiKlrHf8CAqGSgS/HOUTSc
	Vbo/tak50Suk6WihQZnY+lbsO56vAdX2WzUckHaOyzfc6TPTojRoERihhnjrwtfpO3W436C94ER
	9+zKE5mZZVPpTjLJM5XiC3d1Qqe9r11xlclfxw4NuTrgcndGCT9NBbn4DIUPQcQzw8edAzuzTJ8
	9gR5ntrl4X/0n3aGFa6HV3nojvqhOZ0gQluD8+keJg8VMD09qhYJYxCw4hYs7qwB/SSS5Qw4yXL
	bakvpgBCidgfgUnK0QByl0=
X-Received: by 2002:a17:90a:dfcd:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-39b84cce5a8mr25249929a91.14.1788988618972;
        Wed, 09 Sep 2026 14:16:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d76aba5d6sm1440472a91.0.2026.09.09.14.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:16:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:16:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] watchdog: msc313e: Fix spurious reset on suspend
Message-ID: <b28e620d-4508-4287-a8e2-7d44cb062a67@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-6-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-6-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:44AM +0800, Tzung-Bi Shih wrote:
> If the hardware watchdog was started by the bootloader and the device is
> suspended before userspace opens it, the ping worker (from watchdog
> core) is frozen and the active hardware timer continues running.  This
> leads to a spurious system reset.
> 
> Check both watchdog_active() and watchdog_hw_running() when deciding
> whether to start or stop the watchdog during suspend and resume.
> 
> Additionally, call watchdog_stop_ping_on_suspend() to ensure the ping
> worker be correctly paused and restarted during suspend and resume.
> 
> Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Sashiko has a point about the bug in the watchdog core, though. We'll have
to fix that at some point.

Thanks,
Guenter
