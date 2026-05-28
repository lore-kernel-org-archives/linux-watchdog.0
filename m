Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF3313522
	for <linux-watchdog@vger.kernel.org>; Thu, 28 May 2026 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779940825; cv=none; b=pq69Z7nOCJ4QxVQuaDhDpu/tszEezHU2OrZEEgU4YTGnxpiJ7YO0M8soIFPqsqtLSmtL9SFClkCi7HOzGuwEOOZGFP2n9vWifr5p5nZf+2tKSyHaXdOe9Z05DoaIcL7X8I6qn2d5lCaQkxxHeAeSe7o45Of5Gh16FaN1G7O2OaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779940825; c=relaxed/simple;
	bh=OC2scjddsaFcqRZLFYVh3vgAxL5RdPt+CMo39s6dN84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvGpscOGR3ymXSwGx9W3eFMJ2Dis4GRee4QgEO+gqMS9hUFUBqkmmRbzzHGWemCg14HVLuulyVYnqz46G2Nf0IdMMQjGbomTVik8ZCqXiv3QBnJF45FsvYtT5+SHSii0BA4LxHQRPMOAfu6AFK7WFYppgAe8gq9mqxwYbETom6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDv38uPm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDv38uPm"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824c9da9928so6046983b3a.3
        for <linux-watchdog@vger.kernel.org>; Wed, 27 May 2026 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779940823; x=1780545623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FPE05wilTfP4Nb+u1gX4DKgV/KvnwhazVOd9Rup8C8=;
        b=pDv38uPmI3B7ACFf/KOyfnYWeqY4NmSzy4ZVlqxX6ich/x/c8HN7YQVOPfC7wxG7CT
         XvOOR9rXl18T2n6MyUMflc5dM20Q7fhlzk7arkwRLDC3Xj/goL+nyFscSyby9+sO9Yhn
         p2mVjLFE5f1FKLNyU19VlgX+ukunUHPlaFxbyiNt3YI6Gy9LSAYsDNwHMHi0WTgqLq3m
         UDHNSch6IY/2TqfQ6DzRXV62GtJyP8LIWal9oE9xksg3t8TgoSimqBpviGx4LKXssOO4
         8Q4gYozLMHneGiCK5wI3H5hSA4yITj19FbZp7MIWWibytl+aqnQr6nTjb0SsKZYf/UjU
         LTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779940823; x=1780545623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FPE05wilTfP4Nb+u1gX4DKgV/KvnwhazVOd9Rup8C8=;
        b=Ch1/FuiG7wKvPMUMnShdls0T1g1STCYA54T0S/BIi539MdDF4nrl4ghTP/InpYEAxk
         hY04V2fBzG1L8XwtiCQxpCtWcJc1K3GcEcrmlYJYly7vbcd4dxmZUHPvce5i9Y8VJ+sH
         uOK77Q/owt8WyWH/gS0h6dZgiuiLST6kUvE1lN33fZJtbUfICQjYsq681sLPWCX7ghDl
         CDmWgc8IHBgoEDHqn3J5dKU93nUNQbZVQ5F9IPxK7ViiFiqbTUdLgHAGQLV13JDllr1F
         AwgM3ObZC/xZivfEQY8oepFr0FkGrmKbgYTtyD+hwGEN9rgx7gpRPdHKrYSz2yPSx6ag
         /LZw==
X-Forwarded-Encrypted: i=1; AFNElJ/PwRDMm4EHw1Ia2TwZyLz3t0Nv5ckAzIJPT8YHb7MYXMuvBzjHjPKPQ5WdZS/j7bfcjzCIuVPIFDm8/5MK8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOOAFh2zbrWwgdevYL82HgTmZNM4yt8jnLkioLwOpI35tiHK83
	KlB8vNvgmsEMbe6Bug9T6M3ZrPuM0lKKl9FON04ychn/ECpT3Um2Hjxr
X-Gm-Gg: Acq92OHbvMN0dAp0GEvUp3Exyu0po39ZQogfbpj4NmxSHp0kJ+f7RwdWXpv3CxU0P+z
	kNM7Eo974bOzcXVbHhtP6nBKQF+H9uOX2tQbH4BYsEXe2dg3abiV2e0zMF+MCnKdXwCI7uPv5fT
	pvNhppJ7zIOzA9zhmHl+v1L5CRo2ZOknD9qNdtbItKX3zilVuZ1gp12o7lmrCRa8LJcLBdIP+Xi
	sd9WCuyGTqRgNfmDDaFXYNFnofV879VgZ+58L+ouz+RRRH9fNyiwC1D6oCaFI3GZrzsmWU/W+wp
	ApI1mfK6OOk6q/TRUKsImxrE5mIY9KQ+4kKPJDqVxyEa83MQanMD44TkoRqhhU4biih71eCAf+Q
	iqu/dpUwVMKSbbpvL2tvDsBBk/jvxf06Ye3wanepdG/3ANLMIDncac9T5ZKyy3EnwCDpTrFAfq9
	ZpI+72Pk5xAdHsg+h9fPbr7Vhc1kkFPLTzntY8AYx8y1B/fHk=
X-Received: by 2002:a05:6a00:1944:b0:835:36e6:72b5 with SMTP id d2e1a72fcca58-8415f0e8804mr23044450b3a.6.1779940822418;
        Wed, 27 May 2026 21:00:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6e81781sm3885517b3a.9.2026.05.27.21.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 21:00:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 May 2026 21:00:16 -0700
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
Message-ID: <3d285a40-b371-4e61-9648-44c2fbdcb3e5@roeck-us.net>
References: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>
 <51fb3abd-998c-45a8-a058-ab9185d6fd7f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51fb3abd-998c-45a8-a058-ab9185d6fd7f@oss.qualcomm.com>

On Tue, May 26, 2026 at 09:40:53AM +0530, Kathiravan Thirumoorthy wrote:
> 
> On 5/11/2026 4:19 PM, Kathiravan Thirumoorthy wrote:
> > Document the watchdog device found on the Qualcomm IPQ5210 SoC.
> > 
> > Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> > ---
> >   Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> > index 9f861045b71e..21f6f7db7f96 100644
> > --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> > @@ -20,6 +20,7 @@ properties:
> >                 - qcom,apss-wdt-glymur
> >                 - qcom,kpss-wdt-ipq4019
> >                 - qcom,apss-wdt-ipq5018
> > +              - qcom,apss-wdt-ipq5210
> >                 - qcom,apss-wdt-ipq5332
> >                 - qcom,apss-wdt-ipq5424
> >                 - qcom,apss-wdt-ipq9574
> 
> 
> Guenter,
> 
> Could you please pick up this change? The watchdog device node addition
> merged in linux-next[1] is triggering the DT binding error below.
> 

Not yet. It may sound trivial, but I will need a Reviewed-by: tag from
a devicetree maintainer. Patchwork does not show one, and I don't recall
seeing one either.

Guenter

>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC [C] arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb
> /local/mnt/workspace/kathirav/upstream/linux-next/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb:
> watchdog@b017000 (qcom,apss-wdt-ipq5210): compatible: 'oneOf' conditional
> failed, one must be fixed:
>         ['qcom,apss-wdt-ipq5210', 'qcom,kpss-wdt'] is too long
>         ['qcom,apss-wdt-ipq5210', 'qcom,kpss-wdt'] is too short
>         'qcom,apss-wdt-ipq5210' is not one of ['qcom,apss-wdt-glymur',
> 'qcom,apss-wdt-hawi', 'qcom,kpss-wdt-ipq4019', 'qcom,apss-wdt-ipq5018',
> 'qcom,apss-wdt-ipq5332', 'qcom,apss-wdt-ipq5424', 'qcom,apss-wdt-ipq9574',
> 'qcom,apss-wdt-ipq9650', 'qcom,apss-wdt-kaanapali', 'qcom,apss-wdt-msm8226',
> 'qcom,apss-wdt-msm8974', 'qcom,apss-wdt-msm8994', 'qcom,apss-wdt-nord',
> 'qcom,apss-wdt-qcm2290', 'qcom,apss-wdt-qcs404', 'qcom,apss-wdt-qcs615',
> 'qcom,apss-wdt-qcs8300', 'qcom,apss-wdt-sa8255p', 'qcom,apss-wdt-sa8775p',
> 'qcom,apss-wdt-sc7180', 'qcom,apss-wdt-sc7280', 'qcom,apss-wdt-sc8180x',
> 'qcom,apss-wdt-sc8280xp', 'qcom,apss-wdt-sdm845', 'qcom,apss-wdt-sdx55',
> 'qcom,apss-wdt-sdx65', 'qcom,apss-wdt-shikra', 'qcom,apss-wdt-sm6115',
> 'qcom,apss-wdt-sm6350', 'qcom,apss-wdt-sm8150', 'qcom,apss-wdt-sm8250',
> 'qcom,apss-wdt-x1e80100']
>         'qcom,kpss-wdt' was expected
>         'qcom,scss-timer' was expected
>         'qcom,apss-wdt-ipq5210' is not one of ['qcom,kpss-wdt-apq8064',
> 'qcom,kpss-wdt-ipq8064', 'qcom,kpss-wdt-mdm9615', 'qcom,kpss-wdt-msm8960']
>         'qcom,msm-timer' was expected
>         'qcom,kpss-timer' was expected
>         from schema $id:
> http://devicetree.org/schemas/watchdog/qcom-wdt.yaml
> arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb: /soc@0/watchdog@b017000: failed
> to match any schema with compatible: ['qcom,apss-wdt-ipq5210',
> 'qcom,kpss-wdt']
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/qcom/ipq5210.dtsi?id=7a473107f9785700a5c57cee69f60c19a9703f95
> 
> > 
> > ---
> > base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> > change-id: 20260511-ipq5210_wdt_binding-9f77d959a28b
> > 
> > Best regards,
> > --
> > Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> > 
