Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A02E62A8;
	Thu, 12 Feb 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889956; cv=none; b=qCH9qArPRjt83+c8WzUTm9XeVLzSAziCb9uL0uFvPGhLVphD43xAvuTCEA/0hHkbponQHV9L5KSgQvHPLy1jqdwAZMR0Ra6q6OI9C3V4JP2uEFK5nQIZ/sz4rC/yXXSmaYvlsQe3Or3mf1LNDe5ZcBe7mntmZVM/PF5YB/sD4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889956; c=relaxed/simple;
	bh=ZJO2M53nFm+7JNZYH4Ke5ZPuzhwbrJ1wCVlgTaFyThE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUyK7Xp41DtFcdrazHaam+9IR2dyb/ibetFM/TqMPf3N1Xd6QJJ2UMUbiTgdIVWNZZ+b//mzOH2IJTomFvNBS29vMZLR7MyHPpRnWWnKAJtkAfarBrgm8Jg5iPWzya4USoP0e6G3s4w3opexQbSOuQKisgzSksYsfApmung+5PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mCX3NnfO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mCX3NnfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770889953;
	bh=ZJO2M53nFm+7JNZYH4Ke5ZPuzhwbrJ1wCVlgTaFyThE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mCX3NnfOb/urR0DSg9JK0PA6HkIVPkKs0IrUqxWke0uoA4Lv6sh5JthDxhc96rfaC
	 HHrXGNHb3E+PRjB+gPLX3yNgM6sHm2GALWy3ykCBnLHspOAF3mef9RuLeiM1CrcDWM
	 cnFVMxKTkV96I+kS+mU0eauJfUluZ7ozuxJLfsM7HWL+ZEWPiDlfOGMSZOVXKTS7Qp
	 P2k3UF8BoaqhJfGW36glmMiHKk6hzFpwbIgOJbFpur50QnrCh7GRTe86itiDADIbXq
	 Nya+CPDn6nKUMcw4ZA9ZG0TBKKt7yKZtX0Pqteu+0uE6UFLjO+FC5iKos9kU0O+Cv2
	 BNQnCRS96gFrw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 37B8117E1428;
	Thu, 12 Feb 2026 10:52:33 +0100 (CET)
Message-ID: <9e4968fb-8a04-4ac5-bb48-016cdb834af1@collabora.com>
Date: Thu, 12 Feb 2026 10:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] dt-bindings: watchdog: Support MediaTek MT8167 wdt
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1770836189.git.l.scorcia@gmail.com>
 <560b1985c911ce25950c9caedc42677ae01fa8bb.1770836190.git.l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <560b1985c911ce25950c9caedc42677ae01fa8bb.1770836190.git.l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/02/26 20:03, Luca Leonardo Scorcia ha scritto:
> Modify dt-binding to add support for mt8167 dts node of wdt
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Please put the binding patch before the driver patch (you anyway have to
send a v2, so ...)

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

