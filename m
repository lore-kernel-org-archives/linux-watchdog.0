Return-path: <jcm@redhat.com>
Message-ID: <55F20461.20904@redhat.com>
Date: Thu, 10 Sep 2015 18:29:53 -0400
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
        linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org, al.stone@linaro.org,
        arnd@arndb.de, linux@roeck-us.net, vgandhi@codeaurora.org,
        wim@iguana.be, leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        dyoung@redhat.com, panand@redhat.com
Subject: Re: [PATCH v7 5/8] Watchdog: introduce ARM SBSA watchdog driver
References: <=fu.wei@linaro.org> <1440435683-7343-1-git-send-email-fu.wei@linaro.org> <1440435683-7343-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1440435683-7343-6-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 08/24/2015 01:01 PM, fu.wei@linaro.org wrote:

> +	/*
> +	 * Get the frequency of system counter from the cp15 interface of ARM
> +	 * Generic timer. We don't need to check it, because if it returns "0",
> +	 * system would panic in very early stage.
> +	 */
> +	gwdt->clk = arch_timer_get_cntfrq();

Just thinking out loud...

What happens later if we virtualize this device within KVM/QEMU/Xen and
then live migrate to another system in which the frequency changes?

Jon.
