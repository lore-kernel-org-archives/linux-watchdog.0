Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E93ADB9A;
	Mon, 20 Jul 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528735; cv=none; b=SeklexAJJnoc1mm6DtW1QKw2+JYNdbz03158bH1xdun6CdiFtD5V5niqiEyAN6w4K38CF2VxNL4QkZoni4QSj22yDJSVCeYz9zm1H8LHr8Bqm7+SH19fEFV26EnSQgPNtvjRaXhjohPzYhXw/Kr373JwEKKzCJoCPUgZc/s9y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528735; c=relaxed/simple;
	bh=3oeJdcKL0XE+tgXHrw7zPgR7EzPywu4raO6qtwoDZZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUyY1JayWfmQEWBnf9iaqTc+GDClwA7qdvVmkeIIqC/EwrEpraud3SKeJXvgzhnClZJ5i0q1ij49PgqxrXLEAeVQPQLA3gDRkZe5FwvDo4GbhhTe+1qw8bBmcVWqJp+efErpS18XFN/TeIxFu+G4vcNtxsxKbgoNeCV4z1NMTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsQIgxyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsQIgxyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6067E1F000E9;
	Mon, 20 Jul 2026 06:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784528722;
	bh=Bx3gsttsL8btelDKsQYDh+3/bOavT+Adp9VCPD3qd+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YsQIgxybjrk7faLE++FmKSV3ktlpxiJL32be2JLGgMb/ND86aiUyGL7NiY1XAB/YA
	 lrVvjp2czMVRHPZU7d9TSLg6WaPv/EBRoBRRzcDL8ubHITPS/D9C7LYx6/WI/7A/rt
	 8f7N0tATE6JTt+f6qXLZSTDMKpk1kfz5FierAP7Qj56tR5Cj1gnJKkHSw/GuJ1im7z
	 x/Ew3EAtPk6Ce7asZGpgojsjaAApQ+gSA+d6muRqzIh7VU+02LDudV36PY8tvSBw8v
	 QrwX68E5CEdXpux2RYsGZzhC6cS//KOTGJ8H/J/jlaEOI0f0/6k8CbIvx3L6GI6NO3
	 UjYIIZTHv2chQ==
Date: Mon, 20 Jul 2026 08:25:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] dt-bindings: reset: Add MT6589 toprgu reset IDs
Message-ID: <20260720-gabby-strategic-goose-b61c4e@quoll>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717163959.714561-2-l.scorcia@gmail.com>

On Fri, Jul 17, 2026 at 06:39:12PM +0200, Luca Leonardo Scorcia wrote:
> Add reset constants for the 12 MT6589 toprgu resets.


This is not a single-patch patchset. Seven patches.

So one posting per 24h, so we actually have a possibility to review it.

> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../reset/mediatek,mt6589-resets.h            | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6589-resets.h
> 
> diff --git a/include/dt-bindings/reset/mediatek,mt6589-resets.h b/include/dt-bindings/reset/mediatek,mt6589-resets.h
> new file mode 100644
> index 000000000000..ee08c39df513
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt6589-resets.h


Why is this header being added outside of patch documenting compatible?
You have entire commit msg to say something useful instead of repeating
the subject.

Best regards,
Krzysztof

