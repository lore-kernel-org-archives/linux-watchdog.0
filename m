Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBB44238F
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838598; cv=none; b=dhCj8m5COok9bJFhvYTqaKEtg4/P/jaSC2D4HrwmBJkRoDMwFWWDrs1bw85nUqYKny/olYKVd4bNIV94BZ5PY4n2qX0uWWLeoVqW5FNHHZJao1R/Sc2kSMJDeHQyHhoA05CGOA0l/9/YHtTx4uTQYrLEtsO+Mb27izSXHXFK/TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838598; c=relaxed/simple;
	bh=7f+4mzELTObpPjWDb2bQLAcMvXmQA6lI634JqMznuyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXL9395pkB/kweh2/S+KhuNKk8XGq+lzJvcSIRIWsRRBgfRSvgYwSU/TLEFsnykVQg7vF8C+9Z/UqcAw3XX6gEHoeJKNWUnZSudqyjxCH9wY3SKTHgyfXCkTHDlly2iGMXpJ3an8N355A67GSujH8tamk7F97PITfHkqxQRyhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqTCB/FJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqTCB/FJ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1105239a91.0
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787838597; x=1788443397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZcqJsOk8WyALrofDgPKRhkK8TJsmoKsFAfVulwjePPE=;
        b=pqTCB/FJx7Ds0Y8GAFkIPYENfJAg76A914YUq/vrCSMp8nmW1CMO1l6nIs6IQmwyvC
         MBXoir4myybcXcmaU67ICh9sWNufwBGvP8vzxN3/FBZwfOafzpW1PcXin8trFA4vwUPB
         L1PMvUvTz+B9npMpLyC3d59tfiQOwQ6R6w/yyyciW3Bb8bqUmA6g7BVuuLSHXM/6rPIx
         jgdfi80Z3eLJ4Xk3a0BQGrTv7SyepE1LiCMrsMC5JbjkIUZmkCVc79HeRHBbR4h9nAzi
         rpKBUXaPxHqLse34y6bvKzqJl7lHp/lPO526H160GUVD+KUsyM2AWmXSKDjb6IMnITWd
         E71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838597; x=1788443397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZcqJsOk8WyALrofDgPKRhkK8TJsmoKsFAfVulwjePPE=;
        b=jGKKLEQ8aRXxdGTdHdRG/qFGXd6bGrKTlnwzdwl/NGbrTIdeHzM6ehjX9dLQbYS/0z
         ilsXU6eZ8f60TcEg5FPDevt8r/WKWwDQtmWNBA3g96RLrhAqYLCpYuZDltFS6o2urD7H
         8cB6rxRYcdMKe4PqN8C6xqzdrxw9dcTZl4yOW2lj3PUoFgH3hrafFIp6Oo0IExl05pDk
         vm8hJ2Wre4NIa1gfi6KzJjTpTgFS+cBlZY+3jfHibbEJJnGiUJBLhUlyutsykwb7EyfX
         7byFpk5gKSfgNyBE8lKJtQGm++AbOfJLDQmBKi3QcjHJ4T1yzB2R0Q1qVIxnQzcpWOzA
         xYNQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYvPJY1rfZdr6jEX9rCnR+rFXM7JRWQreFRawl4v/qCme2oSFCGpOucQUrknBuFVvY6nZWgfnJ2G2Yux1/5w==@vger.kernel.org
X-Gm-Message-State: AFuF++mSTb03mGt5JUiGYPDbqkPDqvzTa9AiXgngQYYvptOxGN7BKJ+f
	alxf+6bn91GWzZdw21MDElinXgIqcimN0Ow+icnTKHtC34Kb65yy2Arr
X-Gm-Gg: AR+sD13yokKjYNr3UBdFXhgiYcoouuKLbZCCvCDTtSQPnCm4QPCX3ih5OhTsip72+As
	KSt9KtHlOvAaY5GRwweXsZKBv3fJWCwo7F5uThWlNohyZZq/LdAGsZitCQzVORbtZESUgIPoK/l
	TbKJzeYSRg7vbDA5U8YLHJi0zMRwFIPCzxrH7WS+7fnt1ttL17nTYajdDnqpSzDIBV6l3iZx+hE
	pv9pLvGEHMPZ/jB+flvWHzCAIkAD1WuSxFBn0dXnaSayTUuxvG4Ee1iY4uK8Fjx57ynnZ9FgIYt
	iMAUjbQKNv1IOWJ2fxh03gsJgJdDUmDS5LIly4lLBuLQNMCUXiJlg1DcYUz3loef2Ks2xv/zThX
	naBFjX8VHhRnUU6HdV38/BX4i2Z8DVX6dr4zj0Q7/Ro4RajBvM1Cnoek8Ee/oVrn1meFIMi0K//
	eJi1YLLL7+qWl6arwdVkMwuzsOsr+DXneu8nI6Ou/OpGfHCtqkpHJsRQBYj3bJ44QJOkIcpBTk6
	Q==
X-Received: by 2002:a17:90b:3949:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-3966cde3f0amr31804223a91.0.1787838596310;
        Thu, 27 Aug 2026 06:49:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd55a4sm2941117a91.7.2026.08.27.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:49:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 27 Aug 2026 06:49:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aiden Isik <aidenisik@member.fsf.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Message-ID: <a7290d71-53f3-45fc-b9f9-f7982bc15b8b@roeck-us.net>
References: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
 <20260821-for-next-lucky7-watchdog-v4-1-d070cee5009f@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-for-next-lucky7-watchdog-v4-1-d070cee5009f@member.fsf.org>

On Fri, Aug 21, 2026 at 04:14:49PM +0100, Aiden Isik wrote:
> From: Aiden Isik <aidenisik@member.fsf.org>
> 
> Add a dt-binding compatible for the Exynos5515 watchdog timer.
> 
> This watchdog requires a syscon phandle, and the cluster index should
> *not* be specified, as that does not make sense on the Exynos5515 SoC
> (due to it only having a single core cluster).
> 
> Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
