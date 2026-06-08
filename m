Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCD3E4C87
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945021; cv=none; b=VHrHc4HgWkGOHGyB3nZfVx0QjV03XWWccGLwoK7nhTj9A2AOwHCujOigeKWSCGGCrA7+jgs8kHVMIEtP10fonGB/tStDY1DH6rSAmVkpGHoySaEBnkBbUo3V6rQOxTGI/9j1TT10NjQ9pin8GiRNPsIUWwYbPYBmKTSv0BiDqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945021; c=relaxed/simple;
	bh=sHRgZReIBWpW5NdfBaanZpgYqI1k260TPLXuy8TIblI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvChKtkQrheD9Cj36LgN7Z/PrpxJk3weB6XrSVx6n0Kbiacp2N/7PfuM4eGJH8P/jRCgxFvlfR6I7g7YRz58Ix3O+H5CEqpmeBPZmKXOXCWVFSjMeGpQDNoXA2zOlObs+rf4KX+BHbj1bLE0Iff73WtrH7ds98fn1CqDG8xtBUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWOCw9PM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWOCw9PM"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-842319576d5so2646765b3a.1
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945020; x=1781549820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhXTrIGzEozRTYZqrvuBs+osNbcorCKCcPcM0I49+xk=;
        b=RWOCw9PMyf2fTpkNnfFyd7t9MtV1t0B8XBlBx4F0mBFY4EIC61n5Niu6dHqvep+qFJ
         zgFANamEuV+RrdRLwP9kzX/1oiCiWSw6Pd7jMPdjckZ0CKCFY2JydUoaPaHbPyjtQRPr
         NHTsALLCfm0IP8G7Ui+S3hOS6UOzq7qHWwYlXccjPHcdVqd1t3mWvn3yKdBMb+e/uu36
         rw467FC9n0fr0wgYTkSmc7LngSzuxLM9SMyHarZYiJex5xGWRe9VhRz/4cqKB0ZGLjfE
         1CrDZl3HZvcVtMbQoKURlpYVecIx7Uo/HPsr4vlOnIdVlIEcY0MbLDxoqcCukOXOZ5mL
         Ko/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945020; x=1781549820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KhXTrIGzEozRTYZqrvuBs+osNbcorCKCcPcM0I49+xk=;
        b=fSDez/Zbh7IDzgs8VUbFIyn70+AHy9VJMi+IbemSIXuHx+rE0R9HOoMtsLEs2SYz2d
         6YspXytNb5Sf7fqbno3+jkAXRsrLDhpNsWrexz7I9eZ7D37uUhqYXx7eqGXsSlSBY5/X
         qFHNEU4vwJ4iKnd8EUrUWdPIMpjOOblwPdVYA4BSgOtRZfNrMse4AsC3AMYDinGWoNjA
         n9K8BozqjkdZIcg3kj9LHSpneIRoDtxGNiWLaYxdIqVYNEmWibpXDjZNmRx7p02O0C40
         vLIoSU+QlXAoj1MvM6yCK/ZaraKdog1qrgCGqlnsDSAwFbBw42V0Sc+EpfgV4sr9hlJU
         XKjw==
X-Forwarded-Encrypted: i=1; AFNElJ8LBvsrLIYQU8OgP4apuH8QuwsRAgxKHgvRR+yNn0M8ywJy2TaEb47ujbOR+4al89fPxsJ6NhaMFQdADw1NGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8MQG9ZqgVRa4wKXrsR8VUBNluIqANHzkzK5rhT8bP5y4gqvq
	bqrVUfowxRAnvxb2fr7O5hQ1NnAbfDPYVi3JiMZwG3vYwHT6VkLdet1l8R5U3TQ3
X-Gm-Gg: Acq92OELE3kqv6oIksf9virnR+prE4qcfHSwdL7/E+woqMIKV8lfwCMlwyupDqd97fL
	avXFX15/eBPmhLFKksDE0BHoPiLO3jZl6/lhhe8CI1VW2jvDYFeC3QgdGbvq2i/CL1VEuLKL4AX
	z47AR0Ut9LVS379ckhXEE0xTVSYPeh9Aswt7epHo+epH+v+uBC1PWbjS0nmqGYORGFXb7eI3n2l
	LlJ5l3c12kvInJE7jyPGwhUwuYa8AiJGSJOfWn/U7ZCT7Ddgu3FvuZppCvJlaKwbvRbyErPUfNC
	u3m1b5IasR+wqYyNgGCAHbFqPdUzSyHRSHDKg80BVqbzGuMPVDXUO3jxhCoYnxKKKW53e19imS3
	IFQECktpfQ5O26prh7drlgr1U4ClyedPKqyiWf1hbXmhqKqWgjfQA4b5viiTOWN7hTxosT/r2lX
	FLf2Jyqob8ogN11j1m39REW9oJ1SCpCnsbh35CFv+gTuqMb3PpyG2hO77kbA==
X-Received: by 2002:a05:6a00:94d6:b0:835:366f:5da2 with SMTP id d2e1a72fcca58-842b1051617mr15667359b3a.37.1780945019804;
        Mon, 08 Jun 2026 11:56:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842829188b9sm19476589b3a.59.2026.06.08.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:56:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Jun 2026 11:56:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Document IPQ5210
 watchdog
Message-ID: <31356c7a-6028-4901-a98b-5cb375d7742d@roeck-us.net>
References: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>

On Mon, May 11, 2026 at 04:19:13PM +0530, Kathiravan Thirumoorthy wrote:
> Document the watchdog device found on the Qualcomm IPQ5210 SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter
