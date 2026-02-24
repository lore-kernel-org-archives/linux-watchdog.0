Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F263A1E75
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Feb 2026 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946759; cv=none; b=X/v3DtKfShe94UOktjHjosEh9MZSInTJn3O66n+Lc4X1qZyj8QYSfeA62p/xcRzlP80stWn4HheZ0nnqrmiJwEaIaKRt09T/qHq5ZGYLCEpfSl8bzGPxIElzhucYi032OqgCuVsL+N/gxVW+NQTyBpXH/kvL1t91TNRNPPlMBLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946759; c=relaxed/simple;
	bh=QnbAFPGFthzvasBmUjYWWjZFAYjww/ilHVXgXGc5JRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRQOTIIZyvlu3s5M64Q/+an9sGEI31S0VAyF03dSeL60v169f5JpHbXAWGmphspFAOqhaNUvRVfWEkdB2gFVKtu57SO6Zpy5XNkj0QeTQ9HwRAedopCRLriHuvwMm1FGscTstDYwUMJhVS3HX7V9qXdJXFsX+qqC2NwCMZZqoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN/i+j6a; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN/i+j6a"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1274204434bso4320101c88.1
        for <linux-watchdog@vger.kernel.org>; Tue, 24 Feb 2026 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771946758; x=1772551558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrV9BhMxEEs17TmWJHa8CNzBUwr0TwzU8O3qC1THpDI=;
        b=aN/i+j6a5JD5cyFWNNDYDTYXIAOZOhLz+ChjE/yEnqjRkzrNuNwkcbUNECkqJBg1pE
         DFTXvgJkiTnXeZs6X3rsZ9C2BHAbOU567iPIiPwpmFUzp745ZQTOaiq0cSlRYthDDE9c
         Cxsn8h+8onogw4XCMPNJLQJcCiPLBWbnZVobUlOdIx0gm5xIEJUOlthbEWG1AV1IpQan
         1xWpF4GOyaC0cJ42rgsNE37sGPd66fqpT+AACgpPEl5yezMuhtV5vxVqV/Zo8088lF9C
         A0d/3gUDI4jTs8s+q4RwNZTS6FP+rUHkE6Aa44QKSOTGANwBOAH5EgyhFfctmzkHKXKj
         86ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771946758; x=1772551558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vrV9BhMxEEs17TmWJHa8CNzBUwr0TwzU8O3qC1THpDI=;
        b=ccLfr3rriXqdKtCX/im9MaPpYDzFZWRJjp/amY2RYQod5p7vlOzajGpD8eD2hXQRkh
         GDPcJluEd8FvOx+n08ad5aANiAJePucfKRVAWNYm63um9AQ4SBiNv3De7ccUrbpKqxtn
         jKy8xMAYwvfX8oJ1sKeuO8/rhUTWG1oniFizycTqIoeAa0Uk+ltWESIgbi2fbILV4BfV
         vBvPrxmhxY1mr3ymcrIdZIwXF55f4g7zoEOo+YLqkbGvqSyxpG9UnAPueU2u/GTOAn23
         02Z3lYEqLN24Gn213cWURIq4K+/EfzrJGNNzv5vox7w1AdXkSnvZ35shdTex4OqX5ie2
         YdEw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZkNS8VtrS0UNgOUzVOXpICl0y4rtxmWwZoVxkmB6mGKlrfIdrzo61TOVrdu6gq8Qgvmdh5qbtz/BISo7ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1SVH1e5STPK9Jml+yfQq1UZ/R1xQl78iX7xmTCcQmLMVBiMH
	4nztwygZKFaWx+li11KXBHjo2hAv4AniCAmA0ZssSW5txmGL84rim7Xm3GM5z+xd
X-Gm-Gg: AZuq6aI3DGX6oCFWduG2cfF6dMC80EdJ/k9M2TtJVq0uT+a0/NzLYEJn83RfqS5Fqw8
	jMjlqAv06FqzspVzWqO8kiNo58z21jTHJcVpCwc3E7IAYtUMb9y5+QCdr0WaI4JsXd7dpQJbZuN
	dPAiFBgDp+JZoHDtDm5K4JWUyLrQIL4K8Nt3qQLs7NwN5Kdxw9b/laWuOjpjriTmp5hsBm0o8Rt
	FhAmK6av+wxUo3f3BIZftp2iv7C6UpsTsRig5zzfdLg8f5UcxCgyVT2jomeF7wW8NaohHDtPeBR
	e7zvO2wh3EoYNxdWowMy+MFuryISYJQGmOBZ/wubb1XaNyc4S8x/47cXH6thFVjK66tWQWxgC1B
	BhyZaas3O0gLmgmLpITgNDDVdC0kakxnjQVHjCEmDmtVFjTc/Rpx1oickfUh1U2WVhXQ2YiBXrn
	T7wjPAIXAqNZ/0OB1Um9/h2TdSotAb22ucIple
X-Received: by 2002:a05:7022:421:b0:11b:ca88:c4f1 with SMTP id a92af1059eb24-1277f5606afmr123769c88.20.1771946757470;
        Tue, 24 Feb 2026 07:25:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af7ae99sm10658338c88.10.2026.02.24.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:25:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 24 Feb 2026 07:25:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/8] Revert "hwmon: add SMARC-sAM67 support"
Message-ID: <05db17b0-d9f0-478d-bbe6-1efdd9802abc@roeck-us.net>
References: <20260223100459.844967-1-mwalle@kernel.org>
 <20260223100459.844967-4-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223100459.844967-4-mwalle@kernel.org>

On Mon, Feb 23, 2026 at 11:04:48AM +0100, Michael Walle wrote:
> This reverts commit 443b39c82c322c9f3c38bea0389fe927ba00b3b4.
> 
> I was just informed that this product is discontinued (without being
> ever released to the market). Pull the plug and let's not waste any more
> maintainers time.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Applied. Please let me know if there are any objections.

Guenter
