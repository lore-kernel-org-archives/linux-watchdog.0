Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF2345CAB;
	Wed, 12 Aug 2026 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567984; cv=none; b=qufea8whnknULtgEUMtzfzV0OoUwgLcD88hhBFyVzg3z166Vgs90XZ6q6d2f8/pFvH6iUO1U7XAkHRg4CmFu5CNupHFbp1VATiEqb13hGXmBGu3wyCyt9YNj/XAXDEw/6arwNRCamp9hz0n9oeDYLcA/fxLGhn5lTKSAOsBTM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567984; c=relaxed/simple;
	bh=S7hrZyfdok/BVxOpijpFSBR4DTsdabyznj4EEMVgZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4tVT6QpPHKzV2mj7PTY0WCYYveCnsKazMbeDSn7g4eyp+/EHLrt5a2LqryBNUSPijS4rnHpwUlTHSQ0nYGZsISCTu/cB2gOMfXrWJzL2ZsjQxwQfIYh6xu4n1hT2cYK6zMjzU5lb+wintjkdsUT5mqU4BsZwSRshi33STIqLkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTVb1oQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTVb1oQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59B81F000E9;
	Wed, 12 Aug 2026 20:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786567982;
	bh=PZTHBcpuKzlrB64SfsnV/GeHK7Iy5+hrZaeFB8HDzYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HTVb1oQMw95Z0j77m8GUWBBIYQuZfbfv12WyLQbl9Evh9mmYO0M/Kh5uJ9yzuHZbK
	 458AbkhjTazwMHr2dFuco+aaSObKG46ZyeDRs1t1eNMvgpus2mcSP/JK6zz5r5a1v9
	 kPTpSG+t1+ELWQq7zF3uR+1QGZw3fGG/XiKTnAETtNegZsS/Bjh9YCjxP5hO0GuoJf
	 aoJcHsykRR8yfN6ObMtITtB3UE31ATFOvaB7H1bEMSoNPnQ+8MnoGv04I9qeeZxikL
	 00tiXKeYrCLaKqU8pKsVz4mjpqV47h32nIV5NAW1fRKWqMFbDnA54rAVFW1iipkKIK
	 IPqrTZDPxg9YA==
Date: Wed, 12 Aug 2026 15:53:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
Cc: krzk+dt@kernel.org, lakshay.piplani@nxp.com,
	linux-watchdog@vger.kernel.org, conor+dt@kernel.org,
	wim@linux-watchdog.org, priyanka.jain@nxp.com,
	vikash.bansal@nxp.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	alexandre.belloni@bootlin.com
Subject: Re: [PATCH 1/4] dt-bindings: rtc: Add NXP PCF8525 RTC
Message-ID: <178656798141.967972.14133767418236331657.robh@kernel.org>
References: <20260807082855.3762394-1-shivprakash.gupta@nxp.com>
 <20260807082855.3762394-2-shivprakash.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807082855.3762394-2-shivprakash.gupta@nxp.com>


On Fri, 07 Aug 2026 13:58:52 +0530, Shiv Prakash Gupta wrote:
> Add a Devicetree binding for the NXP PCF8525 I2C RTC. Describe the
> optional INTA interrupt used for RTC alarm and timestamp events, and
> the INTB interrupt used by the watchdog.
> 
> Add properties to select the external crystal load capacitance and
> temperature-compensation crystal model. Also allow the common
> start-year, wakeup-source and reset-source properties, with
> reset-source enabling watchdog registration
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
> Signed-off-by: Shiv Prakash Gupta <shivprakash.gupta@nxp.com>
> ---
>  .../devicetree/bindings/rtc/nxp,pcf8525.yaml  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf8525.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

