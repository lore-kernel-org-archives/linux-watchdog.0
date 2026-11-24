Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483712;
	b=POEmGjI92LtpgikQwcmNO1uvTpNXQ8X1lOleUL7EyWMjcDeRwQVN4QOpr5PIrWl2OdCu
	 kGMXpEBiUj42Fqbdl3wghteP0BlQ+B2RPJhoCY+MKRiCNmnZV4PtpRc4dQXTCewjHAfKx
	 2Lpob2A/ZNh87AJ2I8YAb4kmIpBnaq9P6fUnP1mFXNiBXcGneF1LZdq58QDGHUJmVX09z
	 D8IewcJq5kPT1qVSTDeuePvuqrFwe61AW3ZHfM8Tf01uymSkAOjE4AelUhw0UlwVjjUO2
	 FbYuhNfsn1MzONPa4UxBvWxwN+9f/bO2JL+9CYlNN+5HuG8NVFMTFk5G5Du8OguHR0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=k1hUmWFG5GUv5dEmsxSMypms0FRXPv0dsfB0/VoVKS8=;
	b=dtnmvqovBm+I6MfmijWdCO1Z5FsYmwpOGxtNAKRj5mpr2MiZkv3Hx8KrxmvE+CJ+sd8h
	 /Ar4xsZ7hYKAsdjgC/x1f/Ogfu7Q97G0RTQpbCTA+NjU7AuYgNEXU/LOEYcudFU8KP2O0
	 E5qI48oClTwbwoTRlLUI6U7yjHiWtfwWy+d8Tlpxub3ZvNbtg0fzs4u9JM8nefZDGDa6l
	 meHT+jqzpyzU3W8K3ZmdcY2bifMw0ZKbG6m4URvd1c4y67PJsNmhX7Yw7HbdgDOgYfgwO
	 8eOX/zSJi69kPWMY5H3vdXVsgs/zpoeis0/F2+A8v/amnUCSzL/E/8VvZbouoL+XJtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSW+NJmz;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7A606A327
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 01:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03E7A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dSW+NJmz
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so1834616b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483711; x=1796088511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k1hUmWFG5GUv5dEmsxSMypms0FRXPv0dsfB0/VoVKS8=;
        b=dSW+NJmzISfK/j5aHCTR6DFklJgcWC+dMJDQYKMwBVBVcNFTqNsk1m0Pge9sSadbP/
         xM+ai5CJVbyqjyg8gowTYXCN9EKeJOKDjJjF9cIcMgqh5rjYSJ5YDGoCL0p4ax2HsyfR
         PQlR4Cc6rfPIDvJeSG+t6IQy2ZqE4B7tDxR7vd3Y2/Min2ckJcQsUjx2nwarvSqGA73g
         m55dOWlDqOZwsvKg5v53Z8p+jzyDv+k9sJHv7E/SPCQwPzZRYan3RG+cHoCulGsPTmVa
         XInkezb1+2a+/LVMpHOCB8D62PyngqclyqSIDOdPgGoEvoPs6+PB+fkwmA/Lizi4fQZU
         T2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483711; x=1796088511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k1hUmWFG5GUv5dEmsxSMypms0FRXPv0dsfB0/VoVKS8=;
        b=VbVKrQ+q591m1ne78LjmVP0EuorX+QGpqS7bVRdPvL87rH58+KumUcEZ24/Pponolo
         OpYXF1qlEgVnlA3w9wEiq+bTwK/HGdS7y/5G85qfZt68yYmL8us444Tv2kur/YxiPiuq
         kwXxgH1D712etjXu50E0RC1N5RwJoKq0bW7lJatQepYK7487oNDabaPjaFtDM/ZAbsUX
         9cIDR2mAokU1X0g+jXFdXTAEhIhN8pbQj5uaF1r5EMGlbIrXT10dXuaGuvDvjAXlJ4EB
         OUSfa25uTKlyEP7z3kuG3wwCnDRAaVls9WXS8oIMxodAVWAxtHy1ZyIGIiY4b33TLglf
         +JWw==
X-Gm-Message-State: APuU4Z9fl8f0J8899SQbxNggY3szC6ojS4RpAggum9BK1loSIM4JikM0
	9o6eR63KwmeYfQOQPd3ic0i7HIeerfsNj6gABY1HnI1U+QnF0KVuX1TJ6nBm60yn
X-Gm-Gg: AZFdTZe2xzWfC+GPyzw1OfpKiJxcW9YW5XuAFo1dfkNPPE9R/XS5rliTiiQQlVt8kEr
	vAZQygWcoTJTZOLJJGv4Dh8wsJzy1PTQ9w69kRh8A/8SAN1Zzz63lLrWMt/L7lGw/sZelUDSa+v
	PzSLdiqfkbof/tn7YOC9RK8Y6aO2wD4TDZOOUYg9TmKV6T1IS+XHT488I1GuP+u3Qxmvh3OpnLw
	bymMujrzmuuaXRfAONu2Ih8Pt7EyjmmxPtkki4uiNyEM/E8W/KVfctcZWG4ZtNZ7Lq5kNLIf4xP
	aBhVln9xxfG3QjF4B7i1FCfJAQVaQSP0FGhuSdCf3b/zNEH34CyGjxmG8BfYNYyhGmpKaJnkWx2
	xmll+50RmxRcUGjBHdxILt9oyQTL/vXn4YT5eUhBZuA5v1NOr0pPXgQlf5zZC4GmagS29RLHGLZ
	RcjqGgX4Ktl278y2m7lrh9WQ7PjNj4c74JqeT0OLiJn4HAF2lcTmt2DIDImByssp9A1HUJ8iCqd
	laoWU0aXwHABrDBxqADL2FkfnOk9mOm5o60fB30JZ/95zdEqjK7VPIlx8R2EYhgwDP8sD64evPi
	ADEv+IwpbUMMzK0GzaoudVGPlcEj70R5sJp41G/zZAOHQlX5B2bTst6a+tnYmaY58AkXipyWb9x
	D
X-Received: by 2002:a05:6a00:1788:b0:88c:fa50:1a86 with SMTP id d2e1a72fcca58-8c87c09ec5fmr11915415b3a.25.1795483710678;
        Mon, 23 Nov 2026 17:28:30 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4d0:8e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm6115243b3a.30.2026.11.23.17.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:28:30 -0800 (PST)
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
Subject: [PATCH v2 0/4] watchdog: histb: Add HiSilicon STB watchdog driver
Date: Tue, 24 Nov 2026 09:27:34 +0800
Message-ID: <20261124012755.328774-1-mmyangfl@gmail.com>
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
platform driver to handle these SoC-specific semantics natively without
regressing generic SP805 users.

v2:
 - fix issues reported by sashiko
v1: https://lore.kernel.org/r/20261122065549.3265519-1-mmyangfl@gmail.com

David Yang (4):
  dt-bindings: watchdog: hisilicon,histb-wdt: Add HiSilicon STB watchdog
  watchdog: histb: Add HiSilicon STB watchdog driver
  arm64: dts: hisilicon: hi3798cv200: Add watchdog node
  MAINTAINERS: Add HiSilicon STB drivers entry

 .../watchdog/hisilicon,histb-wdt.yaml         |  56 ++++
 MAINTAINERS                                   |   8 +
 .../arm64/boot/dts/hisilicon/hi3798cv200.dtsi |   8 +
 drivers/watchdog/Kconfig                      |   8 +
 drivers/watchdog/Makefile                     |   1 +
 drivers/watchdog/histb_wdt.c                  | 305 ++++++++++++++++++
 6 files changed, 386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/hisilicon,histb-wdt.yaml
 create mode 100644 drivers/watchdog/histb_wdt.c

-- 
2.53.0

