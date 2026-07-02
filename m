Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D64DBD70
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001826; cv=none; b=GOnfb1E8RPEFjn1Y/SRRz9inHoNRlqM0KHSy6N9bwbCxgBqjMde4tQ3mm1IuiMdxjBN9FIJ+f5JRvCE0xIHHR09KU6aNbY9KzeZsbDolWjLYO4PqQpp8pn66lm/ux9FKkFkoPHMgNgYecmDbhuYOdONJE4vMzGCv9MkQGkPgYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001826; c=relaxed/simple;
	bh=z/QCxWHRxRaxp+FLSgd4Mq/o8qVzePyKt3vk51sDvy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6X21BIVT1+Ze8TH4sot08SAdbQsd1y5ZBzMgCGSXYIcRx/8XfEA2AMr1jKuXwKqRHBCW2/9RFQQNGZcAJabSjQc27g3QDi4Ami/ZphyW1vz1CCqQgkHAQTgwYkJ8BiAemxjLcPTtplH5M3+SmR2kMgrNyNlNYo9vtIFQcwedzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEfaCn62; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEfaCn62"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c9c9913ddaso4594845ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783001820; x=1783606620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y6e4pqP3mm87wGSrdo1SyRap6WnXTNDpkEgJ6z1bjhI=;
        b=iEfaCn62TKPq1cAksHpKNReejADMTXqwg+XqKXJxq/GXoK2wkBU6Hlkos5qswagTzG
         lwpA3pRt4I4Er1GGZvP8GlEAII93G9dG3Cywo9UWQXN3RLLDA4VerYy9gwWT72E/AszT
         RpFXCN/4SqrruzFIztDY6ViSZqAaliA8CMtkGx/SK5S9UDIOwX63T/UzoRZVLCAw6NoX
         i83bACQWfR9d4wCkKWzev23so6B/gZMP5IqUuHl+k0q1Rav78fznRrDROlgMvxYNi4XG
         6SCw4gG4yhz65acqm5odvlj7w75KXyOx9gBpNQFnUGZgh64rzafziM5klswFUVPKn2Dh
         eN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001820; x=1783606620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6e4pqP3mm87wGSrdo1SyRap6WnXTNDpkEgJ6z1bjhI=;
        b=rsCOEGvggIu2HyEQZmE1aOzy/mV4hw7YqNMV57ERibvKKR4Jb6ksUCw8AQjMtmB03T
         vlGArQSVhxiSMOzApCtkySdUfy9t4Jm2GdnSHAoDVJBuzgavyUpA1h+QJVPkdek8//RO
         GISL3NVVRlHhCGRsyJfoGZAVfnOQJnG6WQFaWo0XDeX2rfwS/OV6WCB+RyvzAKeOz+0L
         Myr4/FROQ0HSB3MFLLyfWVaq3uhVAGMlzXPXrEvRjjwWLDHj/Cpa73Vl+cULpSrzmMFX
         uSLcACIg5V3lTSGptGzi7KD8f6Z2GMAB8rof6SRZu3grA9oNXIabvbasZjsOTIjWua7i
         1tLA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7eh7uEqPIKwYKJM5GU6OM5W3y1vNTLOfNv/IylgC/EcGWRxDEVitz8cuFbrEpB9W+JrO9XETUIlRKNBEvGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2by5kNzTUZMHUC7cW5H/p1kNVBEzdCAbwXHMoXnLNlAHYJk5C
	AmL8cEYu3oHuoYytimeU/8fuJqglcYYNeIsQ40oBnVVJadd6mJcgmMdA
X-Gm-Gg: AfdE7cnw4wUdpkHkyskNyx5I/I1qggkMGrKZFppUVnKu2a6LtMPhbI8kXlZfENLB5nM
	nz7KXfUV7V5HocHs44my4fkUZYvj1GQM/BwfTqCmwlx/umxQL3HO0bsd+VmATXCOVjnisdxVfyW
	w2lGgqHcXUbla0SvgZvxheyKJ9SGBDTA7DlVrwXArpPtrAfbbsqkGbWVPK2AGfVlY5q68szwtMt
	D9RLjZ+YoCckKqIHI2uHcnP4STE9l5emvRxKcTiAJVIAP0a/FO/h/g/uM0cwJ4da4/3u6DFn5+h
	0UwPosU4xc+Fsn69UoW6qLgPTJrK9YmLDBc8BPzMkFjz+Szcu1Eca6PNf/vNub8pZ5CvLzUbI9g
	/yqO4sy3GKrMqJVUAWJ5QVFM0YzMLKqk2cu44kds5uvQSQj/7xOGbg12mpaLsyqSdREBQ2cUEVF
	9ddlm+OiRCsnXttYDviSse8l1AGg==
X-Received: by 2002:a17:902:ccc2:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2caca49abbdmr1430485ad.0.1783001819551;
        Thu, 02 Jul 2026 07:16:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa009a4sm14177615ad.66.2026.07.02.07.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:16:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Jul 2026 07:16:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: Document Qualcomm Maili
 watchdog
Message-ID: <04954526-126a-4470-ba9d-501b943dabe1@roeck-us.net>
References: <20260629-maili-watchdog-v2-1-5cb9c83a581c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-maili-watchdog-v2-1-5cb9c83a581c@oss.qualcomm.com>

On Mon, Jun 29, 2026 at 12:09:05AM -0700, Jingyi Wang wrote:
> Add devicetree binding for watchdog present on Qualcomm Maili SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter
