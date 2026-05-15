Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48443290AD
	for <linux-watchdog@vger.kernel.org>; Fri, 15 May 2026 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808964; cv=none; b=RSXNQNg4sf1+LaTQWhgXb1pmr/OCTQL2mZDsjhmdgbNFoUeBvM46bWbAGSZmKHj9gpUDmXFNdXv0+f3/OjH82MfJ6Mknq09zkOZZ0vBcfU71p71mMnBtO142HHCx1NVP/aRWnIc9ih3uTpQ4S8efmsCtRs1ZIsPDn8i/5eOO9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808964; c=relaxed/simple;
	bh=qyG+SWsCYJzW6ePta0HqJQ0JlnEc88TZlimHgFAjJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHFDsfnH7Gyl/DdTIcxuVmfshvZagHxqkH2L+F697m30cXBC5HCVrpcCumT+TOypAweJrv6DCwWht9xu9xNQEGk5DK/32UON6igj6FQA1hUQdGRml9aJwdMsEQGcwoxaUmxGYN7/KKxLQPsn2CIw39eszDJVAZ1nDciKVqLZzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7vS/yh/; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7vS/yh/"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c15849aa2cso11817458eec.0
        for <linux-watchdog@vger.kernel.org>; Thu, 14 May 2026 18:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778808963; x=1779413763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krEBTTXiK5mCDN2/ksztHps+97IcSWBntWKsCM99zy4=;
        b=a7vS/yh/+bXHSvfjhxxRKShavtNDHg3JqYLQFNg+fynr101ELtBp1OePyLnelfpk0p
         T/AGq9b+3n/KkmVYgOP+26qgiT/K7+Rbsg/HFlqG6hDVcLg0LDXcBzsRJtaD5yxafomq
         9dfzWLEzVqcIHnZtpnTpR0ckANM4KeNVFOWlhqRK00ZsuuhHSNBsgRoGQwjjUh6CNeAQ
         6CqCJQpjjn1rLkTe18Uu4miqgmYbn2FxoyTDrjLg2qwb5zOwpaORs5H81C4beXeR+C2P
         Flfusr8cgkKKT7PZFZuRA7SzlB/mRDAcB0uehU/VCapqPMjrLiKpoTswkrzY5fndsUVm
         2Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778808963; x=1779413763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krEBTTXiK5mCDN2/ksztHps+97IcSWBntWKsCM99zy4=;
        b=FhcuBBz+MXgRoGDjIVOe5L1gGpHCSOonbtc0Vi1Cdxh2s/WFZKWsBk2Uu0cDKWR4M/
         yvADC6oxEH2oCp4dnsstzwDjLf9AzvCuOvEhm9kJditEQiQPpeCJjm7Hjw0x/xH+o3L9
         JsAFutssloleYAYM283elMhcZihF4jk2z1CLGMB6oprf1kDehhGiFKmCEWTQfb3zBudx
         AAuIP5FO3FZUZleeHj3XogTWU5UtgLH50FU5MfDG0Sd4SqPXDV2VdtW0xV72GfnPSLgs
         Fnw1cU6fXUoA4bWydbu5umAHSA1TIPXQBsxR3NcpPGagxV28W8lB81VoF/3UpjD4/JSP
         Ekhg==
X-Forwarded-Encrypted: i=1; AFNElJ/6MG3n5v+/hcvM0guW/wJq2pc2tOIzg73e0RsulxdZSeMPrQFr9+tloHbfepqyqMlw8/9VfW/jzSwRCJeMRg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDA3SUb3mV7YLST003XLjop6ATYBynQDkJhOWIKfEKFkQH1i87
	NHdNYupZe67fA0xFFhxD6hXk06Fi3quztqEldSxNFXHv5HCv+A9XFHvp
X-Gm-Gg: Acq92OEWdawydvRJ3UlIbeYhRx5pzeOpMXrtnsLCA+lajGaTNmze8C5ezal0gfUAwN/
	ipNxMwoydwwrUrf1WU5F0wKETVR4cAeCjpoBQicdXTKmvukR0OnJonyPyNqgdid/Bk9mcmNZlGr
	1iNdDCzDWBrsFA8nBJAMf4mFsWFQZ2AWY6pCbl8g0f0VirjqGfo/s4o9uiD/y5O2MQyM5hSYx2V
	SUXoN8bfTYy84WaAHdrfUvxgvOC6SovnPDUzhzptCJIw8a6bgLL6dgG8B5P+Tm8/DUuIQkQk1Yh
	ADwEvmQnKFlFKiJ8bh6KgKTelGfMvFkFTHaeJAGjVXhcTriDTh+lTUEbtlc0edE/WuRkpR9Iz5g
	HBSXn1yHHxyTCLvL64bm6rJXygfXWX6qg3Ra1yRvAUynZ1iopaKs9fXNSTEo8/kTngV/4BxZNqd
	tJjjgYuxsWoHeUjxv/jH4JZFsBMmlvg74h/y7z
X-Received: by 2002:a05:7301:600c:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-303982b788dmr969693eec.8.1778808962665;
        Thu, 14 May 2026 18:36:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcd0csm5316673eec.24.2026.05.14.18.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 18:36:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 14 May 2026 18:36:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: qcom-wdt: Document IPQ9650
 watchdog
Message-ID: <d06d3948-acea-4f92-b032-5149735733a2@roeck-us.net>
References: <20260511-ipq9650_wdt_binding-v2-1-dca22892d3d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-ipq9650_wdt_binding-v2-1-dca22892d3d3@oss.qualcomm.com>

On Mon, May 11, 2026 at 08:10:23PM +0530, Kathiravan Thirumoorthy wrote:
> Document the watchdog device found on the Qualcomm IPQ9650 SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
