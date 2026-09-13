Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1EE274B46;
	Sun, 13 Sep 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288574; cv=none; b=i8z5qc56eZ5ffJEerRLd0Gy+8HTIkxoYNLV+ATeT5vO0e0RekwUg6hbnJO/06Z5DU5QMlKLCiT7TgJ6t34eydduCnYabgrAR7Hgc57bnOr/9eIcBtLdli7P1XLFa2cozkfJFDAnBCwOAGpoCvDiUxUAtpVeDMw93VyQj0nX4Fgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288574; c=relaxed/simple;
	bh=736WKsw2kiTCxXSNKpOq3RcVKAJWYQCPOu5zbOEaj9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9T+6QRnfOkxEWSPjbRIyJgDPXTusZJfzLzqGeguykzGmfXiFUVFvWUR5srp3/04XOLGQqSYRMu+T3OCKhj1yBG0Jg/oL478nJ5EpCfJFludyjG/S7A8mCs3Aj1Z3FtKQiax19ClBB6GfyaJun3V1aWuTVmQEMUi6ZeDHnhyOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAj2JaJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAj2JaJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0959D1F000FF;
	Sun, 13 Sep 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789288573;
	bh=d8WurlmhkA4e6m6wqPDqGz0fYjsjwdZG3YnLtCKxAOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YAj2JaJjtipqC9sZ5QQPmMWXy2aHSiCBhyK7zDQ6fMiC8WHqiryZrWSgKSgzNEJF9
	 Q9+ULcFDj+lHGgaMb74R6N/SbSmXnrYjI59pxm8Qrdskdltmw+3aqk2OZSfi8mYggI
	 drjJfatC3GtB7P2Z898f8ECyFKlhpoZOo6uPmVlO8h3JTMs/3yXv9ZfqlSvEupLkzI
	 gPgrQcaOnmNxdV7QMef2MZNI/lE2dWpftedqR4jSDMkHllIDnn0fke7IBeTV/DRIdF
	 qinLfQZiLb+DymQUDpb2Wi6HRA/n7txhXsLIbfCey5HfKxrHodUJ7RDZhLrzl5aFCV
	 FdU0FCfXCq5gQ==
Date: Sun, 13 Sep 2026 10:36:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 6/8] dt-bindings: reset: Add mmsys reset ids for mt8167
Message-ID: <20260913-moth-of-wondrous-order-4cb0ff@quoll>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-7-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908174259.9009-7-l.scorcia@gmail.com>

On Tue, Sep 08, 2026 at 07:38:33PM +0200, Luca Leonardo Scorcia wrote:
> According to the SoC data sheet mt8167 has 28 mmsys resets. Add the IDs
> that can be used in device trees to identify subsystem resets.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../dt-bindings/reset/mediatek,mt8167-mmsys.h | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt8167-mmsys.h

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

