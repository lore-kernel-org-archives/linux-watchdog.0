Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B91486647;
	Thu, 10 Sep 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051299; cv=none; b=kOC3PrpPIGPprCGXakDxh1anzmjCXBSa5EC5ZC1oJf511aYr7J4wprVUYZN3rZRzC7xoImCir7T/CKGA7BlP+3HYe0KgbKoMRkP00KSSDAKAF2WI2ee95uc7z44h8qOtgPaEy/dlXQtBXl51txSkMAKXuKDTtE2dgG9puH42zxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051299; c=relaxed/simple;
	bh=NQhEknJQA8Ya6L5zdIqdUOsD85jIBAx1y0eYH103iRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SIVxpfTh34phbtmWujLCiu0o27jo+wdJ4dC2xJbi0CKrt37bmseqpwdVqdTFSZJ4S3pdfFEv0zWjXG6owY4I1axrQhxA2hbdmhoeFEDEwD3NAvHUXiqqbqbtycCTNp5rNyLWecmeeME9V7s2Uf5P3d2qBh5WVpr3cGYEISznv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l/3pZbar; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l/3pZbar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789051295;
	bh=NQhEknJQA8Ya6L5zdIqdUOsD85jIBAx1y0eYH103iRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l/3pZbarrLBIxC/Bgeh0sOVvNAHiwRlpACyCd/tvr6a1aDM1yE39N2cpwZK+VQkVE
	 MgyWtOO0Dc/G1ZYcB3Qm2E1JLOY5QbBZm9ZMoR9VGyxl8WU4ADu2K1EFkl5j0Iad/6
	 XiSMMocF2vJVEhsJ1ZOcck/zDrlzfTgL8Y4/YjcB/mFxDppjKilV/UtDKUyEpZP31Q
	 mTKYy9+55otmsuxQ4ciXEEflpRBMZuFFQOBurS1VbeCxTqCCwf68d/vmE7JBrSXGzi
	 NWXbHAsrvc2mgBb8+DDl0wZsc62pBjWjXdb1zlMM5WGG2NQrb7qk2p8HS+ZRws6USc
	 ICkrBPI187SkA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D79DB17E05D3;
	Thu, 10 Sep 2026 16:41:34 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Zakariya Hadrami <zkh@mailbox.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, zkh1@proton.me, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
References: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
Subject: Re: (subset) [PATCH v5 0/4] ARM: Basic support for Amazon ford
 tablet (MT8127)
Message-Id: <178905129482.89344.17321319958555136692.b4-ty@b4>
Date: Thu, 10 Sep 2026 16:41:34 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 10 Sep 2026 15:29:11 +0200, Zakariya Hadrami wrote:
> This series of patches adds basic support for MT8127 SoC based Amazon ford
> tablet.

Applied to v7.3-next/dts32, thanks!

[2/4] dt-bindings: arm: mediatek: Add MT8127 Amazon ford
      commit: f97be0d722ebef4de65a39813778f6ba62c2ac1e
[3/4] ARM: dts: mediatek: mt8127: Add watchdog support
      commit: 5e23e7d730c6e984e4f03c3b25e2188de9f4ba99
[4/4] ARM: dts: mediatek: Add basic support for Amazon ford board
      commit: 2e195497fc9fc0dd89cf95dab80a2d0486dab65b

Cheers,
Angelo


