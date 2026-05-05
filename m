Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6CD2F3622
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987068; cv=none; b=u/6iaXN8k98iaum6Vh9i13RQBiqZsUq4p8jUkX0DGdKBDoyD9inPWCMWvAIonxq0/Jna15Qd3tCdjQFtCroujTRFi2g16u3eZhGjo2KVj67iOTiwwJkFvknYxgenUqDmvacLYmF2lzdSustK5+1BxOcz6bPCmlmE9jFy0NFNJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987068; c=relaxed/simple;
	bh=yZlednh9nVTM+xIY3GdlLz29I02HRrnjp3HlVqr0/w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHK2QEuUSUsuNXM+1qgJM9xTe2yf/mBy2czO59uszgL9bDDZpDaKY44RpsoN0OA1s3rEhrcGpP0SZOnMLBiM/WEPeVCtwM90p1dZJwCeCKVwiGbfgRkTl+pYgjBSJUnNERKCdXutdLEJu21950BiKrQ12jaAcjO/Mhf0HZKb3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2914lqM; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2914lqM"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c45281a06so8167057c88.1
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777987067; x=1778591867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7Uwvr8MeFsSApFn56xtx5NITAqS9F0rWz+pR67Hm0s=;
        b=W2914lqMxdn6jzV2p/uMJhBAYPeoJte1DKvNPnqhHKZoGPv0HLoubgHF7GucKQgETq
         +ogT6hUG8mEw0XitLYxWn2Cp7Ee0hHbXwwPYEIqXKBbYMFxigach3S0imqSDH6zGoAo6
         /FSY7k2EDEX3zBrnweN9hccT1AuG88OZnyBGiCoCKFIpfNBH9N17ZKnNjfVb4hfKy6Os
         M1+k5DSa+BMF9ngXeZYPYH0b6sjoPD04Ob8ayyiYdkwtTwhqdPue0K5rt3O2Wi+/87FS
         /OJMp1tyvOR4mUchXt4NgNWPHRpboA+96I/o61rJaaR89gdYz6xv0JcD/aHs5aLtK30s
         mRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987067; x=1778591867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7Uwvr8MeFsSApFn56xtx5NITAqS9F0rWz+pR67Hm0s=;
        b=kSOjkQEnww4Bqhg6dS/dqDZ3cX0fwD7yLpsDb36cZFlSP31lYg4UZ0oeQR1JqOqJqh
         cay2pO4UGYx0s9a7PQe4ngIXbqWNKZ9tfuWKkR5z1CXwFb3M1s/v6LgtqxoWrgN/1SlH
         kHZKQUKGb8IP0eeYCNqAADE1CL/1blzeXWVDukmuJnLxktK5QtJ40++/Frw0m/RFDaIG
         Nhpfz3wFuP1x+8JyMr2N5D4Y5H0DZ5MClvURG6ytAIIHgGAFXzWZGqsbAHbv1zVdNiDh
         kiVOWV9UQDlhVk2TYdOqL6kdjf0JKkZ2+MUG/w4BpRHlV6at1d/PB5bY8GJtdshXTRhM
         Hvkg==
X-Forwarded-Encrypted: i=1; AFNElJ+2FwLKiEWjrLprBF6eNAnVFq4fu4k5tSUhRb2M5nWVxq7QzPfU9fK6VdXD1K9LAyp433Ct0y35eV50NFWFMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMOxREAkAjibzqogSk6n83CYY8hglmorQ3XV7UcqeqlE8Xb/s
	ndCyGhiCL7Z62Wr+Ysj5MbBKWX+5k5jM6dHmOkArBd721waJWsSLgsB2
X-Gm-Gg: AeBDiesPYVSbc/OIF9pvdmaBC8Rnod4T3SkCINTJ8IUfSisAF+4O6QXx9lTUYBlwy53
	3Z8UjJczx39gCdWTB/oiB6mjAG+cL3ujUSGzNiFUyqousavs84XTv+uXk7PuOUcaQTovi7JDYY9
	ecAu9Jrk4v0xmkpwY6oG0tUdA4O+PzEHTNsqVkDx6TzdqEO97YSL83fzAP5hGwvWOmzddH/fTRb
	Zk2CzZCLZectsW9tQQg/j+ju/Fg56TlLpA6tBAJdmPQivkFBimrfdkwCQPKIG0uerO45CFydD8O
	Gu2hCc6JYX0a9uukYiCtAlCW1Xkrf56fPRgpZDs8lRaZMQ74PgiGpi4hiEH5adno7M6OeB2v9m0
	K2dk9o/uxi4wZ6lcnNswnbl5nPjR1d8Sul7w2n0ax20UcEFJ26LlwWDItAEuxQ6JaqgJv06C5a8
	45ajQDFeJFHHzmygYNMDGn5BvAw/xfWW+ZPsHn2GcUTwEPt2M=
X-Received: by 2002:a05:7022:238e:b0:128:d352:bf8a with SMTP id a92af1059eb24-130b1c72299mr1458737c88.33.1777987066539;
        Tue, 05 May 2026 06:17:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm18173052c88.1.2026.05.05.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:17:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:17:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
	Joshua Peisach <jpeisach@ubuntu.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Message-ID: <5856030a-4d3e-4d1a-928b-f9aa0b21f1a7@roeck-us.net>
References: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
 <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-3-b0c2f3519e0e@jannau.net>

On Tue, May 05, 2026 at 01:02:41PM +0200, Janne Grunau wrote:
> The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Applied to my watchdog-next branch.

Thanks,
Guenter
