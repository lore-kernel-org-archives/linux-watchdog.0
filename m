Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FE361657;
	Thu, 27 Aug 2026 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832731; cv=none; b=Aj60eIBp7VeiB2v6JAUVLKK2ztwqMr1LGstoq8S7RHyDtfDPWArTXH2vieGb2sEnKSzHxw0aFx1pSsuIISyzatmZW40n73gJaZ8/IN2UKJt00CMKHjjW2uM9Vm/igPGL1pIRN7dwRQ6oUi+VUlvdhMHMfiE4LqqW9BCxZZB/Fh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832731; c=relaxed/simple;
	bh=78iFWf3uJYsoNXePtoPujdh3aRXqlKF1tSTtK7jnYoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD2e7s1VTD6u4k2xHK9Rtj25p71zAlQFstoaVhHYzBTWx/t/uH0aIidtaSgt62Xlp9zs2QoyrXJznv2ogcrDy7W6z1SW3keJaSvbbMNBYliAK1Uk5CvdSJ8exHiiiiKkdxZo9CUnu1fhst89Qbjcb/nocL4j1EWbnxwzvZMtRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU+h2O0i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU+h2O0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0301F000E9;
	Thu, 27 Aug 2026 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832729;
	bh=dc3jY7P9zE1tJZ9onpOYOdmKX6vk4OXUfdwbcLqkpwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LU+h2O0iP62CpY9efKy5hlR/te82Ux3do6ydw1u2D2GZjjYZ9kV1DVb5+qOTvmMvo
	 zuC+y3dfE7zppjCEpAWbl00nc3QiTxnW3U16cu6GlOyl05Y9hksSYvfYtqti7soS6N
	 QLJC8ZEjTYZyN06JvCsXBmBAKc1fEpw/acpkvaou4kJncKS+j/K4ZcpRmuhdoZYtRm
	 0EBrMcN0/6EF84vLKNVcAPt5WuybQRo15vGqIjSCkgKECPcaIieE/u5JCDCXBPDuqr
	 sMl2eQVIB95lxUuUsFE0LR5qDzcB+7zDEruEg7wSbIykZyENcj3q/xatC6Z1k7U8GP
	 wniRMeEeU9rzw==
Date: Thu, 27 Aug 2026 14:12:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aiden Isik <aidenisik@member.fsf.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: watchdog: samsung-wdt: Add
 exynos5515-wdt compatible
Message-ID: <20260827-precise-fresh-coot-b0d17b@quoll>
References: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
 <20260821-for-next-lucky7-watchdog-v4-1-d070cee5009f@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-for-next-lucky7-watchdog-v4-1-d070cee5009f@member.fsf.org>

On Fri, Aug 21, 2026 at 04:14:49PM +0100, Aiden Isik wrote:
> Add a dt-binding compatible for the Exynos5515 watchdog timer.
> 
> This watchdog requires a syscon phandle, and the cluster index should
> *not* be specified, as that does not make sense on the Exynos5515 SoC
> (due to it only having a single core cluster).
> 
> Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.yaml  | 23 +++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

