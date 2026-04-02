Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292AA3BB9FC;
	Thu,  2 Apr 2026 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119163; cv=none; b=EV+/4x+2C/zwWg66hEW5JdWKCBCwLncF4UdTS8NNBE+1/idl3CWyi+cIOe68Bc80Jgjyz12xlXtfcU8Lsd0BJqpCc04CdPnJKhXhyLDne8NrwqsfKz91w1LGeMmIHqMOWoTeCgTIzbXmhiTmGas9QeauoTWU9DjHWVQe4mSrVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119163; c=relaxed/simple;
	bh=CxpFDWJaAetREy4HY6zBi7yNZeIfJONcSQZedP4pSAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+7OVUHxT4/IT6THuACXdpaYoV+Tn7YFQ+nVAGoewwycSlfcrM75RV8DYhGVAiD5pvH+0iKXGaAaYnMbBUzMN5VeZ+UQTYzyg6m8MOw8oXoaoEa5AX+6snnOWwOtG5Vt9uh5ybmuVhgC9ip+6IFfSopmOS3jtfPxKCxxOevPb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW9C2hb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW9C2hb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B86C19423;
	Thu,  2 Apr 2026 08:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775119163;
	bh=CxpFDWJaAetREy4HY6zBi7yNZeIfJONcSQZedP4pSAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HW9C2hb2mB6Mdl5GJS2NurRG84KbcB3et7PnmsBFAwB3Nl7gvvGmiznfTE7t1BQVU
	 Qpufi0mBRsAxJhJHNK6905+ZSOmFH5r0d99zR84LVHSSd1PlNJrCjLv2PAn/gUMVs6
	 bi1i+6iO1e7ykyTB5MEuVb5pBvkpU8jZtLIjo09zNgupPBvlrGaoyRiMUwYBS7dbFw
	 3enG3F+K5p4IMljHeJ7dmsWAe338zSv7uXltHVHhb3Pc2raF1exubL3AIVgCnpWUps
	 SW/QaMxMupdjfxhzrtAlAwHfJoiGRYy0ac5XVlNPwvkAMcP/OlnyHS2ofc+fu1HpSy
	 RPiQVRhmXViUQ==
Date: Thu, 2 Apr 2026 10:39:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Document Hawi watchdog
 compatible
Message-ID: <20260402-little-dragon-of-bloom-8c4ae1@quoll>
References: <20260401124442.591803-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401124442.591803-1-mukesh.ojha@oss.qualcomm.com>

On Wed, Apr 01, 2026 at 06:14:42PM +0530, Mukesh Ojha wrote:
> Add devicetree binding for watchdog present on Qualcomm Hawi SoC.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

