Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312D335BA8;
	Tue,  2 Jun 2026 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439646; cv=none; b=rx9+/I4kKyS+mjihdVpzuW71UjCXo9FrHlphQXJ7Qb3nWyuPYdxoyQHZea8U0UZ+VP+r16XQQAmhgTDE2w0nRn2G6WdmT1cMTj7p4GxcbM8XA+BOeFZfrxvua3yMz/xI3aY8m2TygOBFkNJJL0eZhiwGUQMSpNFfXeHqGOKIWYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439646; c=relaxed/simple;
	bh=TTAdI3t7nAedPmX5mdl7IImZnFq1bD4jsWGS5JjpjVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKn8YzvfQUFunG9zN+JEvTCJebDM5DSGBhMS4ec4+rbbq7J69Y0t+gG5/ifjpTSdLfMqmkHHwzstvuS5QdP5At2+tIjf4hJAUFjUX+RrZhTAZWmlJNtVIq4VXpjWF4N3vg4ou23J/ZPRUFjKaIS3QApNiht7C6+mYrpjCxOPhF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2FMG4WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2FMG4WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC311F00893;
	Tue,  2 Jun 2026 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780439645;
	bh=Ye+AtCPj6qke+geKQa6wSqdQw/tzBdjQjzKqHFuZgpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G2FMG4WXsKcjFQqb/48PBt6WCkmposK20MYzLFnL3r2rGD4man0HXIPBINPdr9JRO
	 7yjSIuhdnTcGGcD/fDrNA0UboS4ZdOuWNNuR9nHDP/75IytrmmabDsrRj6w47uc8Qp
	 97AAQOzA/2Cx43c/RPFGPijNsJPkq6bpf6UWOxYaAc2mlxMZs0l17FiYtdHO5U6jSN
	 wl/TCEcpQwTBaM5PSJ7pMBSVQKSL0srbmpBVlx5HlZ/VDqsETjofroikEDVo+EwpV5
	 i1tHlDWg9uW6LV7CgO2OaYxUbVGouRi7/pkQKgSdfnv90mdnD9TOwwBX84fKD7UM3d
	 JJhxS6Yjjx+bA==
Date: Tue, 2 Jun 2026 17:34:03 -0500
From: Rob Herring <robh@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: Document IPQ5210
 watchdog
Message-ID: <20260602223403.GA1283330-robh@kernel.org>
References: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-ipq5210_wdt_binding-v1-1-859003d48274@oss.qualcomm.com>

On Mon, May 11, 2026 at 04:19:13PM +0530, Kathiravan Thirumoorthy wrote:
> Document the watchdog device found on the Qualcomm IPQ5210 SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
