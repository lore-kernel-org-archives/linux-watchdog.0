Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D5338939
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359462; cv=none; b=m98SgfH+HXLs5CxhLz2ZUPDcvzHfFxdSRLYW13zbXxnXiiXS6AvBj7ABFFkKEdK+CBV9n0Hjnc9afDAM2B43P2adO7YCH1eKmx+1ogSDZtKD/OdTlvnxCysSqr4PZtL+K8uTyy9HMo9wQVxHH1JJQnDCY397oh7HvMEU0HQ+J2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359462; c=relaxed/simple;
	bh=v2R7RMzgtl4p0GUyY1wULxMAxNHG70RoVQmfeFubRL8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pmos+bIcKaY3WXuPL/o+8xWs3rDeC21FHV6lHogPbZPIKnD0vQ4d3z24P36zab9EcrxdJWTp5zakh1xeHmzuDS8ph604EfW/MyDDSk1AHPEDm6WKYieuMWpT5et73W8ehqaGPPl1lgHLNOl0o/kj7G/R/KjpZP6K/0fAez8ANek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Tmwz7SmH; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Tmwz7SmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783359456; x=1783618656;
	bh=v2R7RMzgtl4p0GUyY1wULxMAxNHG70RoVQmfeFubRL8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Tmwz7SmHDAgLUbBdkKgYKpJS7gp59kkKj6XRcI2cpJdIOO9cBKlV0r14p9wHsP4zH
	 b0dOACHWQ3AHO9qcXZmjzwPPlM20znCP9hiR/NrvjwKfsUMcw/fXVOCMc68m88bNvh
	 x0ErvReN98A48O/teawZ9bv7Fs09pMTfd+w+izmN/j6gHmFq26/4wKoNQi9jW4VdOc
	 luyEcOG8T4e9IVdV2LV1yfiidJ8MvkaeASsTcCagXZdubT4W3MUQXF4iV6CvhGnnjh
	 9yZBn0fc6TdEWmlvgYoZKVCN2fN+btC3fpmF7jwR80JwhlurzVYWkqXH7F7pl9qvAf
	 t9MKIMhCdmlTQ==
Date: Mon, 06 Jul 2026 17:37:28 +0000
To: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
From: Zakariya Hadrami <zkh1@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, Zakariya Hadrami <zkh1@proton.me>
Subject: Re: [PATCH v2 0/5] ARM: Basic support for Amazon ford tablet (MT8127)
Message-ID: <20260706-mt8127-amazon-ford-basic-v2-0-akvkMzQcnDB-79Ya@proton.me>
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v2-0-6859e29e72a8@proton.me>
Feedback-ID: 198761268:user:proton
X-Pm-Message-ID: 879d977e9a35ea1cee412757959b56d4f370c935
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Gentle ping regarding the last 3 patches of this v2 series. First two docum=
entation
patches were kindly reviewed respectively by Mr. Roeck and Mr. Kozlowski.

Link to the full v2 series thread:
=09https://lore.kernel.org/all/20260617-mt8127-amazon-ford-basic-v2-0-6859e=
29e72a8@proton.me

Thank you very much.

--=20
Best regards,
Zakariya

