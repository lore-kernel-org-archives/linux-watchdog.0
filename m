Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437C237FF43
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522580; cv=none; b=dd4EQIl/z/Nxbbc+Y3X3XX3oJ3Oaq8A6Gi3X9VVppKp7hxfNPBW/COdCzWcFGrtFNW8u2+Y8fb0xVNSsvvI+uLIZS1fKqRjuzZJZ9fgM2/ste5/EKnxGt15fFRKZrbfIHNdwzgdDPmk54Xh7BXDwBhmLjE+ep/uRdRhTPXQ+snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522580; c=relaxed/simple;
	bh=XH8av0gw5uSIL/pPQ2x6i9IeY3/kDwiLmSD3bxcaHWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuzg8LC6tOI+CiIGpQFz8dgkLF2bpmKG7CX+D18CNGqMX+9YHbkIVLUua0dlB+v6p1vTBK7PPxygGHEArdVdEmu+l3oy9Me1scjMV9bDyPo2yzymBYdma3ATncHfNDmzWJrWmbgssey3BkQf8ubb71iM5EvDXjIIId7vuNsJHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG1J27iH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG1J27iH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace7da66eso8598315ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783522578; x=1784127378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oYVa7pdFvkhno0EoDzbI3lh7pEPGU97z9M0qko9ydYE=;
        b=IG1J27iHjOwBxzB7uzmODb7OWyzKDjxEY0k6QAZTBgRpybUUN/zO6/Hn0AfnMdPQQa
         XbG8oo4JL6pLR8XzXwAtCGR2ByQ+/KusTUgEwjZIpgJ9ezw1ObcLCAaNm5S7EWMM/XOn
         wmE+JcR7wwbqHphccGcxN6JPHjtKDzfB7Cg6btiPjW0gyZ33GSzozixs88/TIslSuxy4
         tseMI89ulBPqeiPIhQT+XnmD6wy9+EAU1qt9BAUxk1wrWF3TqCZjCjkiLUJmBZHl35m4
         ZyKnz5U1X30iqn7uPYByfPwFmJYt9bcPrkaUWjYRfLquLdz+aoFL7SpzWQ9dqtHngYMt
         g6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522578; x=1784127378;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYVa7pdFvkhno0EoDzbI3lh7pEPGU97z9M0qko9ydYE=;
        b=IdAil85TYBt138Gutn0UgD+PA6WbxPWLE+cF1h0l+2ag3a3nuIt0c7rjU9vftjbFP/
         meNe+pvgH5MUEgDJguHiY4EnNwdrRW/iWP4D+QpUaAlW+HBTE9HfYblbg1kmOikxrEig
         SUjZ0KR4qDXBGjKXJNw3r5p831aWhLEUWGu7CPJzDECrupw5wpIZMiRJgpIg/RGunQRR
         53v25NrRsHVnEhUjXEYB4nzO05VScuG3Gq5fhnTDYauqLAEVOkTvNRlHl191aeAJKpsg
         c8ep6ReMTCFWSSvsj3HmwHDDnEqsT6mU1FcNspO7z7x1ggVUXqhYJSPV5sJuygydTOe2
         3V0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq3N7HzO1i9GxISejdI2Nd2sboIG/QiVa4r7zB0psUN4f7LhVdQUJenX16ttc2wYeYyXcTWR8HjRSYBhi7RZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZV/67K6BoCNew963Oulfhse77NfgjuF3NxFl5WnQjE6zMBGaL
	2XU4MqFKiwjLpJdT/8ghxvwoe7VZX8YjdLYJRe0xVfCB+A15/F+O7YDS
X-Gm-Gg: AfdE7cl/4mHkDMON1/CA1wWTpJee2ym7ENU8AUp5W1za6vBW+evSFoEWH5ekoYqex+c
	Mjr0kZIaUe37hlPE7MxsXzYnBCrRJg2HWTUbjogylyff/dxxk9kTV3t2n+qvCM6gdjsVcKno9iu
	Hi8vcaoCnTCB+2KRaVpPw0pcEAJ0nhr+0tFMipJ8hpAwIjSL9g3vU68eiKrRb+rrBEvLQJALiL1
	Y3QJeNJjpZwSRkMGbG+qU1eNqajKK6pN9auC9gQsXrYFfZJomhRCNV3rri099/P6DB+tUs3qrwe
	SA77DSoydc5QwxcFLbGtXBXdBRNkqILpUFNRla4z4OnqlEXM1/eP1z7sBwQM3PQS7aOSlCoMrIO
	drIQ2BXdc1yYWbY2KptxHtKnae4ZAv6Db378pTv4/KHX90Gwm4XuNt3SWlJev+hoULEbdvgDSat
	9+p9490Wr79x1dzHcGSSzWqZq95p+IlpSogXyh
X-Received: by 2002:a17:902:fc8e:b0:2ca:e0ff:e696 with SMTP id d9443c01a7336-2ccea36aae7mr31727285ad.9.1783522578588;
        Wed, 08 Jul 2026 07:56:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8e9csm29444845ad.24.2026.07.08.07.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:56:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:56:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/3] watchdog: w83627hf_wdt: Correctly identify
 Nuvoton NCT6126 chip
Message-ID: <09087f62-e794-46e1-bfad-153663880804@roeck-us.net>
References: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
 <20260707-w83627hf_wdt-nct6126d-v4-1-829e5f63d548@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-w83627hf_wdt-nct6126d-v4-1-829e5f63d548@bootlin.com>

On Tue, Jul 07, 2026 at 05:45:01PM +0200, Paul Louvel wrote:
> Currently, the NCT6126 is probed as a NCT6116 because the NCT6126 shares
> the same high-byte chip ID as the NCT6116.
> 
> Read the low byte of the chip ID as well to distinguish between the two
> devices and identify the NCT6126 correctly.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

Applied.

Thanks,
Guenter
