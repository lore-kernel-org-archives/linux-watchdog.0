Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330672;
	b=p01iMnlSU3gqxnUHl/K8sa/V+xV4yUQDJb/U46cfCm+5BtI/qsGenWDwS2M7beaTg2t6
	 ENNyTEl/yuRol3vKw6DowaAT1CGfU4+Jqye3UsLzuHxlj6hHi7VC+p6SWQkCoGqMuGltu
	 Xg3eL291MrQcoreXYjYAdRVzbnqhwsOrY/YGh4q2kEFGQGOXUzuUEShJo2+lQn3adYPnW
	 TaTgzShUCTzjsJ/DfFde18Cms63G3XlAFtH+JTuUoWHKFhRoOoKU9lqlcSAPlQhCsr56a
	 Jft07CrAiunDfl3Qq19EiPTmj0+ytRkpSQl0om5w8lGN54+vwIuA3L77YOmZzSDVtsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mCWypRvGlSZbPduNiUdgoulqQKISARZWO/rbiAK73fo=;
	b=A/OYTTKrtuQ/3ZtNNe3akuFMG/VCl0PB1WZ061ZS4QCCshMYDhShk+imbr+0uyQciauP
	 ob4Mp8D8U5UCklPxei1SaGLxFvDaPxln6NmDGWyF4GMLx2ORh7DTdRH0wA2bH/+3hyk6Y
	 cA7CcV6D9ZZdpdL3Dx1yuxKM0k2S6amUCY4zIMBEd1OPt1foWdxY5rY2sc32fiAs9mvnj
	 6WHVovuykfNNlD0GPfZ6tYLWzjGNdDKYgY90IltQozsgqBz8wA3CE07WhSS9vAOcIxPwP
	 efvCiPIxZW4r49e+9N8bzuUki3JV9pmnozxrZQie49DtRQtoE+50pqE7EWE1RjpJNKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrCWerjj;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB7606A32A
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 06:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96DB7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RrCWerjj
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f052ae3c86so9604845ad.1
        for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 22:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795330671; x=1795935471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mCWypRvGlSZbPduNiUdgoulqQKISARZWO/rbiAK73fo=;
        b=RrCWerjjKeBMc1l66n8wiglAZgNNPSW2pmVfBx5+eMaeOi61YGftujVGkNrqoTlKxY
         mCWux9XZysNxG5aUT/i6Ww8SBPOviyTjDiW/wq4Mg37rVuxPCxDEJZySXajHC32gEXJQ
         mnltWemiT1/k22w3TUd3SSFYu3Ddy+HNFhgervGMewFLAxFk2Czq1eaXvlOzEsW+ZBhf
         PtWdjqVs95VU4pRSlv1F6pllbWP0oS713d7hG4O2d2BSkknMUeKapppzFhPVSLYDdlBD
         XzPOfIS6Ro53H5L9xk6l114J5ivN+Xw3l8zNutQij3kRqrhLDKtsH2+SroTUZ8Y/bnlT
         jv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795330671; x=1795935471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mCWypRvGlSZbPduNiUdgoulqQKISARZWO/rbiAK73fo=;
        b=vUSdKqHqS+XzY+YWxi9EsZGzlPLjTUtYMxfOrArQhlwWyW0ouHU3EJ0naw0WTvSPt8
         eiEU3u/iTD37PX4BlvUPmZSw5QsUShQi5cTjVoe+g75L4hpCeVPiErCXQOsxMdU95o6b
         kiIj8BizTP3d9NilnT6CmiM39xztZOFo/7qLMqIz07gsYcy/ZMqfW1nFGnN1kZkEKNk1
         oRLtwL24WSqEh33h67Y49rLoRFZnDrBAcuLDUx0KBcQwohWM5xa7HLCuD6maAmvzbkVq
         4LCJLQYgUJjwrOYax8ygxgZpDlodGcS86zQpJqHZFvd3xfEmltR05DcFTSOT2UJiUUQP
         fozA==
X-Gm-Message-State: APuU4Z9VzGkldPvLTHoFnKyX6u4cPHsWVcPFw5IHZ6fEpipwOK0qlDm1
	c7O6v9J5soE8IK9gEnSfyuEvVx57VPp5l7cy7E26lw1KLPr4lNX3FOZTkNythjQLxsU=
X-Gm-Gg: AZFdTZepq6OzmzZH/3m2jv1WSomYzxbnYiVCgmeNm7UKnwh8pLYltaj9/+kDfnf/v0n
	/Sy34XQCO6O/ezrhh94Q8ujIkdN3ihAHcNiwYOR3yA7vKrjnvDNWPL686aTnyjeKHP4blklpkN7
	vGcMKK+7yEREP0pu7WHPr6NZNICOwYDIj1xoc2lmh1NZgpOHcBmuf/g6Rdx8hijUHto0yGtDC3J
	mU+8qIIy1ZKS9zL4JyLqgZf2qJk/PHyI0HyhfCudIqaBrlbscpJD569/4tgiKms0jP29ezTjqqv
	imcRuXgI8L2NMWu0eT87OFw4vmYo40srgdTNP77TYwrcnylLNl+cbGlPtsOuDWY6cWQFCT+G7sz
	Pv3sghAP0RaRxEys2G4bBOBanBZCZm/SF5cjfO5E6oY3JjXyq82VsNRgWN7Ud4qlVlfvF6kCT/e
	WCzXtv0PxTofO06S4KH5YGypT3wwpvWsm7s6QFS7n1UebBuofLIpQ1TD4c8oJMAN+okml1Rjcm5
	+iDcvD0gaL1cUXedTaMa6BaP9pUrpr9ria6nn0+jCYK+gd8MdjVqPDBOqj/gh912iqh5ZhMUBwE
	XQaIBh1WAKVRPtxOKRAli1vnogQttmr1OVcGXeIPdQEw9ra0GXM2
X-Received: by 2002:a17:902:da48:b0:2ef:ddd6:716d with SMTP id d9443c01a7336-2f03f18fcf8mr80685675ad.24.1795330670778;
        Sat, 21 Nov 2026 22:57:50 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6213:28::4:379])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120016sm34287345ad.58.2026.11.21.22.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:57:50 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] watchdog: histb: Add HiSilicon STB watchdog driver
Date: Sun, 22 Nov 2026 14:55:19 +0800
Message-ID: <20261122065549.3265519-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog integrated on HiSilicon STB SoCs reuses the register layout
of sp805, but deviates from the standard sp805 in several ways that make
the existing sp805 driver unusable on these SoCs. Add a dedicated
platform driver for this controller.

David Yang (4):
  dt-bindings: watchdog: Add HiSilicon STB watchdog binding
  watchdog: histb: Add HiSilicon STB watchdog driver
  arm64: dts: hisilicon: hi3798cv200: Add watchdog node
  MAINTAINERS: Add HiSilicon STB drivers entry

 .../watchdog/hisilicon,histb-wdt.yaml         |  54 ++++
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/hisilicon/hi3798cv200.dtsi |   8 +
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/histb_wdt.c                  | 287 ++++++++++++++++++
 6 files changed, 365 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
 create mode 100644 drivers/watchdog/histb_wdt.c

-- 
2.53.0

