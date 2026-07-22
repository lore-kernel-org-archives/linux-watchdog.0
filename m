Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04644334BC;
	Wed, 22 Jul 2026 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742414; cv=none; b=MsxQinEViF95CMttKI7LNVc8czJG6GEEk1AjuVB2dQchvnV5SYCQVYNV3i+eWKLWN6YLiLi9BXv4lpA78jgPez1BaxA8OpNuuWiaNYHQ1iu9oPMu2ptrYSUEZgVeska1nAjOu3Iqr8BDY7sW29IjDxYvZhgJMZ7Hj9DhJTfqy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742414; c=relaxed/simple;
	bh=kTYYjT5M8kNlgK4vexPnqHan5LuQH3TukAB6V7Z+lug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl4+3BuDsROohjWVAmifEPCo1uVteyO4HJ1045uIR3vApNbSYzp+NhZHFub0jkC0ZVLRm92coW+QtW7tDztTZ5vIv6DwPyqeH32HrIjtXSJKOi95pYqTvvWiy+xZZcTGCn73wVVCXRdtG6xt7pjZ8CXMXgeNusCly2oBzPUSQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRV249wB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRV249wB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF0F1F000E9;
	Wed, 22 Jul 2026 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784742412;
	bh=KZkZF2rPu5ZR/LGvwdw9ibp5FkuwgMTaCsJaW4e51to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KRV249wBia2OVTj+hl1wFx+sYZT1cRQ22nXpTMRg6c1m1AuAHN1z5z0YoOYi0rNA9
	 xNahV+llEnZIX49WanAvWXqJ5AMcVyfxQ3DA8EowWEb8XoCLxNt0xUhTRRZExzt6Vk
	 adjtncUKTmhvXagkCtHFM3YVOwPFgT68i6h+q7CEYj1TV6IOacy+42MBaFZrkdAdNr
	 0zhABJrCYgLP81b9k5ocMGCfY7t34HgQHDYQsM2WV8hdCu5GvFAjXg7nFwk7UyKT2M
	 nxFxk3asIK8EPkmcQNBcevMCEqzAv30uz0bign6Vv/zr6srgqthfx8Mxw8m/sgnqz5
	 EQBzU92wCC4iA==
Date: Wed, 22 Jul 2026 12:46:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Brian Masney <bmasney@redhat.com>, linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	linux-watchdog@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: watchdog: renesas,r9a09g057-wdt: Add
 CPG/MSSR syscon support
Message-ID: <178474240889.1288517.6935023555003107612.robh@kernel.org>
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260716123434.2576253-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716123434.2576253-6-prabhakar.mahadev-lad.rj@bp.renesas.com>


On Thu, 16 Jul 2026 13:34:31 +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR)
> resides within the CPG/MSSR block rather than the WDT address space
> itself.
> 
> Previously, this was handled by including a second register range in the
> "reg" property. However, this is architecturally incorrect as the CPG/MSSR
> block consists of two distinct regions (0x80280000 and 0x81280000) that
> contain registers for multiple peripheral blocks.
> 
> Since the CPG/MSSR block is a multi-function block, introduce the
> "renesas,sysc" phandle-array property to allow the WDT driver to access
> its control register via this shared regmap.
> 
> Mark the use of a second "reg" entry as deprecated in favor of the
> new phandle-array approach for SoCs that require WDTDCR access.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3:
> - Updated property name to "renesas,sysc"
> - Updated description about deprecation and use of the new
>   phandle-array property.
> - Updated commit message
> 
> v1->v2:
> - No change.
> ---
>  .../watchdog/renesas,r9a09g057-wdt.yaml       | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

